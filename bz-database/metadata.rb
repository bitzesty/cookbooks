name             'bz-database'
maintainer       'Bit Zesty'
maintainer_email 'info@bitzesty.com'
license          'All rights reserved'
description      'Database configurationr recipe'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.2.22"

depends          'database', '3.0.0'
depends          'mongodb', '0.16.1'
depends          'postgresql', '3.4.18'
depends          'redisio', '2.2.4'
