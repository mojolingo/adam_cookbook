default['adam']['environment']            = "production"
default['adam']['standalone_deployment']  = true
default['adam']['deployment_path']        = "/srv/adam"
default['adam']['app_repo_url']           = "git@github.com:mojolingo/Adam.Snark.Rabbit.git"
default['adam']['app_repo_ref']           = "feature/simple"
default['adam']['deploy_key']             = nil

default['adam']['root_domain']      = node['fqdn']
default['adam']['memory_base_url']  = 'http://localhost'

default['adam']['reporter']['url']      = "http://errors.mojolingo.com"
default['adam']['reporter']['api_key']  = ""

default['adam']['wit_api_key'] = ""
