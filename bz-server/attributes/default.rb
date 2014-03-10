# packages that go to any server
# usually shouldnt be overriden
default['bz-server']['_default_packages'] =
  case node['platform_family']
  when "rhel"
    %w{
      git
      curl
      vim
      gcc-c++
      patch
      readline
      readline-devel
      zlib
      zlib-devel
      libffi-devel
      openssl-devel
      bzip2
      autoconf
      automake
      libtool
      bison
      glibc
      dbus
    }
  when "debian"
    %w{
      apt-transport-https
      ca-certificates
      git-core
      curl
      gcc
      make
      vim
      build-essential
      ack-grep
      htop
      lsof
      tree
      dbus
      nodejs
      sysv-rc-conf
      language-pack-en-base
      language-pack-en
      g++
      libxml2-dev
      libxslt1-dev
      ntp
      tmux
      libsqlite3-dev
      libcurl4-openssl-dev
      libc6-dev
      libssl-dev
      libmysql++-dev
      zlib1g-dev
    }
  else
    raise "Please specify packages to be installed for your platform family #{node['platform_family']}"
  end

# overwrite me in client chef config if needed
default['bz-server']['packages'] = []

default['bz-server']['domain'] = 'example.com'
default['bz-server']['aliases'] = []
default['bz-server']['ip_address'] = '127.0.0.1'
default['bz-server']['ubuntu_release'] = 'precise'

# allow usage of http://docs.opscode.com/lwrp_sudo.html
default['authorization']['sudo']['include_sudoers_d'] = true
