# NOTE This probably has to be overriden per app

include_attribute "bz-server::user"

default['bz-server']['app']['name'] = 'app'
default['bz-server']['app']['path'] = "#{node['bz-server']['user']['home']}/#{node['bz-server']['app']['name']}"
default['bz-server']['app']['domain'] = 'example.com'
default['bz-server']['app']['aliases'] = [] # dns aliases
default['bz-server']['app']['rails_app_server'] = 'unicorn' # only unicorn supported for now
