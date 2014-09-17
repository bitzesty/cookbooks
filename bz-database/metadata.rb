name             'bz-database'
maintainer       'Bit Zesty'
maintainer_email 'info@bitzesty.com'
license          'All rights reserved'
description      'Database configurationr recipe'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.2.9"

depends          'database', '2.3.0'
depends          'mongodb', '0.16.1'
depends          'postgresql', '3.4.1'
depends          'redisio', '2.2.3'
