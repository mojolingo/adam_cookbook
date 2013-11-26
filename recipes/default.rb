node.default['adam']['rayo']['listeners'] = [
  {
    'type' => "c2s",
    'port' => "5224",
    'address' => "$${rayo_ip}",
    'acl' => ""
  },
  {
    'type' => "c2s",
    'port' => "5224",
    'address' => "127.0.0.1",
    'acl' => ""
  }
]

include_recipe 'adam_snark_rabbit::base'
include_recipe 'adam_snark_rabbit::rabbitmq'
include_recipe 'adam_snark_rabbit::xmpp'
include_recipe 'adam_snark_rabbit::mongo'
include_recipe 'adam_snark_rabbit::rayo'
include_recipe 'adam_snark_rabbit::app'
