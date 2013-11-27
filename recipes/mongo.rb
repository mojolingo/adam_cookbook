include_recipe 'adam_snark_rabbit::base'

if node["platform"] == 'debian'
  node.default['mongodb']['package_version'] = '2.2.3'
end

include_recipe 'mongodb::10gen_repo'
include_recipe 'mongodb::default'
