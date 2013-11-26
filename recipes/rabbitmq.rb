include_recipe 'adam_snark_rabbit::base'

include_recipe 'rabbitmq'
include_recipe 'rabbitmq::mgmt_console'
include_recipe 'rabbitmq::user_management'
