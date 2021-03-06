name             'bz-server'
maintainer       'Bit Zesty'
maintainer_email 'info@bitzesty.com'
license          'All rights reserved'
description      'General server configuration for any type of server'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.2.32"

depends          'apt'
depends          'monit'
depends          'ubuntu' # we can depend on the package in cent_os as long as we do not require it
depends          'git'
depends          'user'
depends          'openssh'
depends          'locales'
depends          'hostsfile'
depends          'ohai'
depends          'line'
depends          'imagemagick'
depends          'firewall'
depends          'java'
depends          'redisio'
depends          'elasticsearch'
depends          'unattended_upgrades'
depends          'newrelic-sysmond'
depends          'sudo'
