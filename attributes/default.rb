default['adam']['environment']            = "production"
default['adam']['repo']['domain']         = "quay.io"
default['adam']['repo']['email']          = '.'
default['adam']['repo']['username']       = nil
default['adam']['repo']['password']       = nil
default['adam']['repo']['tag']            = "latest"

default['adam']['root_domain']      = node['fqdn']
default['adam']['memory_base_url']  = 'http://localhost'

default['adam']['reporter']['url']      = "http://errors.mojolingo.com"
default['adam']['reporter']['api_key']  = ""

default['adam']['wit_api_key'] = ""
