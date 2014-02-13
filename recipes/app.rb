include_recipe 'adam_snark_rabbit::base'

include_recipe "chef-solo-search"

%w{
  libpcre3
  libpcre3-dev
  libxml2
  libxslt1-dev
}.each { |p| package p }

include_recipe "git"
include_recipe "postfix"
include_recipe 'brightbox-ruby'

ruby_components = []

if node['adam']['memory']['install']
  ruby_components << 'memory'
end

if node['adam']['ears']['install']
  ruby_components << 'ears'
end

if node['adam']['fingers']['install']
  ruby_components << 'fingers'
end

if node['adam']['brain']['install']
  ruby_components << 'brain'
end

unless ruby_components.empty?
  gem_package 'foreman'

  if node['adam']['standalone_deployment']
    links = {}
    ruby_components.each do |component|
      links["#{component}/vendor/ruby"] = "#{component}/vendor/ruby"
    end

    links.each_pair do |source_dir, symlink|
      directory File.join(node['adam']['deployment_path'], 'shared', source_dir) do
        recursive true
        owner "adam"
        group "adam"
      end
    end

    %w{
      /etc/adam
      /var/log/adam
      /var/run/adam
    }.each do |dir|
      directory dir do
        owner "adam"
      end
    end

    application "adam" do
      path node['adam']['deployment_path']
      owner "adam"
      group "adam"

      repository node['adam']['app_repo_url']
      revision node['adam']['app_repo_ref']

      deploy_key node['adam']['deploy_key']

      symlinks links

      nginx_load_balancer do
        application_port 3000
        if node['adam']['memory']['application_servers'].empty?
          application_server_role 'app'
        else
          hosts node['adam']['memory']['application_servers']
        end
        set_host_header true
        cookbook_name 'adam_snark_rabbit'
        template 'nginx_site.erb'
        static_files "/assets" => "memory/public/assets",
                     "/favicon.ico" => "memory/public/favicon.ico"
      end

      before_deploy do
        template '/etc/adam/environment' do
          cookbook 'adam_snark_rabbit'
          source "environment.erb"
          owner "adam"
          group "adam"
        end

        ruby_components.each do |component|
          template "/etc/init.d/adam-#{component}" do
            cookbook 'adam_snark_rabbit'
            source "sysvinit/component.erb"
            mode 0755
            variables :component_name => component,
                      :base_directory => File.join(node['adam']['deployment_path'], 'current')
          end
        end

        sudo 'adam' do
          user      'adam'
          runas     'ALL'
          commands  ruby_components.map { |component| "/usr/sbin/service adam-#{component} restart" }
          nopasswd  true
        end

        ruby_components.each do |component|
          service "adam-#{component}" do
            action :enable
          end
        end
      end

      before_restart do
        ruby_components.each do |component|
          execute "app_#{component}_dependencies" do
            command "bundle install --deployment --path vendor/ruby"
            cwd File.join(node['adam']['deployment_path'], 'current', component)
          end
        end
      end

      restart_command ruby_components.map { |component| "sudo service adam-#{component} restart" }.join(' && ')
    end
  else
    ruby_components.each do |component|
      execute "app_#{component}_dependencies" do
        command "bundle install --path vendor/ruby"
        cwd File.join(node['adam']['deployment_path'], 'current', component)
        environment 'NOKOGIRI_USE_SYSTEM_LIBRARIES' => 'true'
      end
    end

    execute "setup app services" do
      command "foreman export upstart /etc/init -a adam"
      cwd File.join(node['adam']['deployment_path'], 'current')
    end

    include_recipe 'nginx'

    app_path = node['adam']['deployment_path']

    static_files = {
      "/assets" => "memory/public/assets",
      "/favicon.ico" => "memory/public/favicon.ico"
     }.inject({}) do |files, (url, path)|
      files[url] = ::File.expand_path(path, ::File.join(app_path, "current"))
      files
    end

    application = Struct.new(:name).new('adam')
    resource = Struct.new(:application, :path, :application_port, :static_files, :set_host_header, :port, :server_name, :server_name, :ssl).new(application, app_path, 3000, static_files, true, 80, node['fqdn'], false)

    template "#{node['nginx']['dir']}/sites-available/adam.conf" do
      cookbook 'adam_snark_rabbit'
      source 'nginx_site.erb'
      owner "root"
      group "root"
      mode "644"
      variables resource: resource,
                hosts: ['127.0.0.1'],
                application_socket: []
      notifies :reload, resources('service[nginx]')
    end

    nginx_site "adam.conf"

    nginx_site "default" do
      enable false
    end

    service 'adam' do
      action :enable
      provider Chef::Provider::Service::Upstart
    end
  end
end
