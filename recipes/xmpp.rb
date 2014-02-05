include_recipe 'adam_snark_rabbit::base'

chef_gem "chef-rewind"
require 'chef/rewind'

include_recipe "ejabberd"

rewind "template[/etc/ejabberd/ejabberd.cfg]" do
  source "ejabberd.cfg.erb"
  cookbook_name "adam_snark_rabbit"
end

node.default['rbenv']['group_users'] << 'ejabberd'

include_recipe 'rbenv'
include_recipe 'rbenv::ruby_build'

ruby = '2.0.0-p353'
rbenv_ruby ruby do
  global true
end

template '/etc/ejabberd/ext_auth' do
  source 'ejabberd_auth.erb'
  user 'ejabberd'
  group 'ejabberd'
  mode "770"
  variables :memory_base_url => node['adam']['memory_base_url'],
            :internal_username => node['adam']['memory']['internal_username'],
            :internal_password => node['adam']['memory']['internal_password']
  notifies :restart, resources('service[ejabberd]')
end
