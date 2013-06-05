# packages that go to any server
# usually shouldnt be overriden
default['bz-server']['_default_packages'] = %w{
  git-core
  curl
  gcc
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
  make
  vim
  build-essential
  zlib1g-dev
  ack-grep
  htop
  lsof
  tree
  dbus
  nodejs
  sysv-rc-conf
  language-pack-en-base
  language-pack-en
}

# overwrite me in client chef config if needed
default['bz-server']['packages'] = []
