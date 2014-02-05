require File.join(File.dirname(__FILE__), '..', 'bz_cookbooks_version')

name             'bz-webserver'
maintainer       'Bit Zesty'
maintainer_email 'info@bitzesty.com'
license          'All rights reserved'
description      'Frontend webserver configuration recipe'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          BzCookbooksVersion::VERSION

depends          'nginx'
