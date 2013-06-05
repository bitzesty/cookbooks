include_attribute "bz-server::user"

default['bz-rails']['rbenv']['path'] = "/home/#{node['bz-server']['user']['name']}/.rbenv"
default['bz-rails']['rbenv']['plugins'] = ['https://github.com/sstephenson/ruby-build.git']
default['bz-rails']['rbenv']['rubies']  = ['2.0.0-p0']
