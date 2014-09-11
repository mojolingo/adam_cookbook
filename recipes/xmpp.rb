include_recipe 'adam_snark_rabbit::base'

docker_image 'quay.io/mojolingo/adam_xmpp_server' do
  tag node['adam']['repo']['tag']
  cmd_timeout 1000
  notifies :redeploy, 'docker_container[adam_xmpp_server]', :immediately
end

docker_container 'adam_xmpp_server' do
  image 'quay.io/mojolingo/adam_xmpp_server'
  container_name 'adam_xmpp_server'
  detach true
  port [
    "5222:5222",
    "5269:5269",
    "5280:5280",
  ]
  env [
    'ERL_OPTIONS="-noshell"',
    "XMPP_DOMAIN=#{node['adam']['root_domain']}",
    "MEMORY_BASE_URL=#{node['adam']['memory_base_url']}",
    "INTERNAL_USERNAME=#{node['adam']['memory']['internal_username']}",
    "INTERNAL_PASSWORD=#{node['adam']['memory']['internal_password']}",
  ]
end
