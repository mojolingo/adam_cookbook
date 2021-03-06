include_recipe 'adam_snark_rabbit::base'

include_recipe 'freeswitch::rayo'

template "#{node['freeswitch']['confpath']}/autoload_configs/rayo.conf.xml" do
  owner node['freeswitch']['user']
  group node['freeswitch']['group']
  source 'rayo.conf.xml.erb'
  mode 0644
  variables listeners: node['adam']['rayo']['listeners']
  notifies :restart, "service[#{node['freeswitch']['service']}]"
end

group 'adam' do
  members node['freeswitch']['user']
  append true
end

directory '/var/lib/freeswitch/recordings' do
  group 'adam'
end
