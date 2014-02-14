name              'adam_snark_rabbit'
maintainer        'Mojo Lingo LLC'
maintainer_email  'ops@mojolingo.com'
license           'Proprietary'
description       'Installs Adam Snark Rabbit'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           '0.1.0'

recipe 'adam_snark_rabbit',              'Installs all of Adam Snark Rabbit'
recipe 'adam_snark_rabbit::base',        'Sets up base system requirements for deployment of Adam Snark Rabbit components'
recipe 'adam_snark_rabbit::app',         'Deploys the selected application components of Adam Snark Rabbit'
recipe 'adam_snark_rabbit::mongo',       'Installs MongoDB for use by Adams Memory'
recipe 'adam_snark_rabbit::rabbitmq',    'Install RabbitMQ, Adams nervous system'
recipe 'adam_snark_rabbit::rayo',        'Installs a Rayo server for use by Adam to provide the Ears service'
recipe 'adam_snark_rabbit::remove_dash', 'Removes Dash as the default shell from Ubuntu due to incompatability with POSIX sh'
recipe 'adam_snark_rabbit::user',        'Sets up the Adam user'
recipe 'adam_snark_rabbit::xmpp',        'Installs an XMPP server for use by Adam components including Fingers'

%w{ ubuntu debian }.each do |os|
  supports os
end

depends 'application', '~> 4.0'
depends 'application_nginx', '~> 2.0'
depends 'apt'
depends 'brightbox-ruby', '~> 0.1'
depends 'chef-solo-search'
depends 'ejabberd', '~> 0.1.1'
depends 'freeswitch', '~> 0.3.2'
depends 'git'
depends 'mongodb'
depends 'motd-tail'
depends 'nginx', '~> 2.0'
depends 'postfix'
depends 'rabbitmq'
depends 'ruby_build'
depends 'sudo', '~> 2.2'
