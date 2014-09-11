include_recipe "adam_snark_rabbit::base"

directory '/etc/adam'

template '/etc/adam/environment' do
  cookbook 'adam_snark_rabbit'
  source "environment.erb"
end

if node['adam']['brain']['install']
  docker_image 'quay.io/mojolingo/adam-snark-rabbit-basic-brain' do
    tag node['adam']['repo']['tag']
    cmd_timeout 1000
    notifies :redeploy, 'docker_container[adam_xmpp_server]', :immediately
  end

  docker_container 'adam-snark-rabbit-basic-brain' do
    image 'quay.io/mojolingo/adam-snark-rabbit-basic-brain'
    container_name 'adam-snark-rabbit-basic-brain'
    detach true
    env_file '/etc/adam/environment'
    env 'ADAM_FINGERS_HOST=xmpp'
    link 'adam_xmpp_server:xmpp'
  end
end

if node['adam']['memory']['install']
  docker_image 'quay.io/mojolingo/adam-snark-rabbit-basic-memory' do
    tag node['adam']['repo']['tag']
    cmd_timeout 1000
    notifies :redeploy, 'docker_container[adam_xmpp_server]', :immediately
  end

  docker_container 'adam-snark-rabbit-basic-memory' do
    image 'quay.io/mojolingo/adam-snark-rabbit-basic-memory'
    container_name 'adam-snark-rabbit-basic-memory'
    detach true
    env_file '/etc/adam/environment'
    env 'PORT=3000'
    port '3000:3000'
  end

  include_recipe 'nginx'

  template "#{node['nginx']['dir']}/sites-available/adam.conf" do
    cookbook 'adam_snark_rabbit'
    source 'nginx_site.erb'
    owner "root"
    group "root"
    mode "644"
    variables application_name: 'adam',
              port: 80,
              server_name: node['fqdn'],
              hosts: ['127.0.0.1:3000'],
              bosh_host: "#{node['adam']['memory']['bosh_host']}:5280"
    notifies :reload, resources('service[nginx]')
  end

  nginx_site "adam.conf"

  nginx_site "default" do
    enable false
  end
end
