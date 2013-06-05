include_attribute "bz-server::user"

default['bz-server']['rbenv']['path'] = "/home/#{node['bz-server']['user']['name']}/.rbenv"
default['bz-server']['rbenv']['plugins'] = ['https://github.com/sstephenson/ruby-build.git']
default['bz-server']['rbenv']['rubies']  = ['2.0.0-p0']
