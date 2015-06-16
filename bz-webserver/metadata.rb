name             'bz-webserver'
maintainer       'Bit Zesty'
maintainer_email 'info@bitzesty.com'
license          'All rights reserved'
description      'Frontend webserver configuration recipe'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.2.15"

depends          'nginx'
depends          'varnish'
depends          'firewall'
