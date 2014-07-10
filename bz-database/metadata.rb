name             'bz-database'
maintainer       'Bit Zesty'
maintainer_email 'info@bitzesty.com'
license          'All rights reserved'
description      'Database configurationr recipe'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.2.0"

depends          'database'
depends          'mongodb'
depends          'postgresql'
depends          'redisio'
