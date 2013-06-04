default['bz-app']['rbenv']['path'] = "/home/#{node['bz-app']['user']['name']}/.rbenv"
default['bz-app']['rbenv']['plugins'] = ['https://github.com/sstephenson/ruby-build.git']
default['bz-app']['rbenv']['rubies']  = ['2.0.0-p0']
