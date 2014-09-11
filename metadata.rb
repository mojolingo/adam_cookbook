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
recipe 'adam_snark_rabbit::xmpp',        'Installs an XMPP server for use by Adam components including Fingers'

%w{ ubuntu debian }.each do |os|
  supports os
end

depends 'apt'
depends 'docker', '~> 0.35.2'
depends 'motd-tail', '~> 1.0'
depends 'nginx', '~> 2.4'
depends 'sudo', '~> 2.2'
