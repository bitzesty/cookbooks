include_attribute "bz-server::app"
include_attribute "bz-server::user"

default['bz-rails']['environment'] = nil
default['bz-rails']['shared_path'] = "#{node['bz-server']['app']['path']}/shared"
default['bz-rails']['releases_path'] = "#{node['bz-server']['app']['path']}/releases"
default['bz-rails']['_default_shared_directories'] = ['system', 'log', 'pids', 'sockets']
default['bz-rails']['shared_directories'] = []
