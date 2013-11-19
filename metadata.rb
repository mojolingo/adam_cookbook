name              'adam_snark_rabbit'
maintainer        'Mojo Lingo LLC'
maintainer_email  'ops@mojolingo.com'
license           'Proprietary'
description       'Installs Adam Snark Rabbit'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           '0.1.0'
recipe            'adam_snark_rabbit', 'Installs all of Adam Snark Rabbit'

%w{ ubuntu debian }.each do |os|
  supports os
end

depends 'application', '~> 4.0'
depends 'application_nginx', '~> 2.0'
depends 'apt'
depends 'chef-solo-search'
depends 'ejabberd', '~> 0.1.1'
depends 'freeswitch', '~> 0.2.0'
depends 'git'
depends 'mongodb'
depends 'motd-tail'
depends 'nginx', '~> 2.0'
depends 'postfix'
depends 'rabbitmq'
depends 'rbenv'
depends 'sudo', '~> 2.2'
