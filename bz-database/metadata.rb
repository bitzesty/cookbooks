name             'bz-database'
maintainer       'Bit Zesty'
maintainer_email 'info@bitzesty.com'
license          'All rights reserved'
description      'Database configurationr recipe'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.2.32"

depends          'database'
depends          'mysql', '~> 6.0'
depends          'mysql2_chef_gem'
depends          'mongodb', '0.16.1'
depends          'postgresql'
depends          'redisio', '2.2.4'
