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

%w{
  apt
  motd-tail
  chef-solo-search
  mongodb
  git
  rabbitmq
  rbenv
  application
  application_nginx
  postfix
}.each do |cb|
  depends cb
end

depends 'ejabberd', '~> 0.1.1'
depends 'freeswitch', '~> 0.2.0'
depends 'sudo', '~> 2.2'
