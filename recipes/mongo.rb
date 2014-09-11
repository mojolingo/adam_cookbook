include_recipe 'adam_snark_rabbit::base'

docker_image 'dockerfile/mongodb' do
  cmd_timeout 1000
  notifies :redeploy, 'docker_container[adam_xmpp_server]', :immediately
end

directory '/var/lib/mongodb'

docker_container 'dockerfile/mongodb' do
  container_name 'mongodb'
  detach true
  volume [
    '/var/lib/mongodb:/data'
  ]
end
