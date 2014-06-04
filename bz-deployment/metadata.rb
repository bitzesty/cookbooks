name             'bz-deployment'
maintainer       'Bit Zesty'
maintainer_email 'info@bitzesty.com'
license          'All rights reserved'
description      'Application development via chef and capistrano recipe'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.33"

depends "bz-server"
depends "bz-rails"
depends "bz-database"
depends "bz-webserver"

depends "ssh"
depends "rbenv"
