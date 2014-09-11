include_recipe "apt"
include_recipe "motd-tail"
include_recipe "docker"

docker_registry node['adam']['repo']['domain'] do
  email node['adam']['repo']['email']
  username node['adam']['repo']['username']
  password node['adam']['repo']['password']
end
