include_attribute "bz-server::user"

default['bz-rails']['rbenv']['path'] = "/home/#{node['bz-server']['user']['name']}/.rbenv"
default['bz-rails']['rbenv']['plugins'] = ['https://github.com/sstephenson/ruby-build.git']
default['bz-rails']['rbenv']['rubies']  = ['2.0.0-p0']
default['bz-rails']['rbenv']['gems']  = ['bundler']

gems_config = Hash[
  node['bz-rails']['rbenv']['rubies'].map do |ruby|
    gem_config = default['bz-rails']['rbenv']['gems'].map do |gem|
                   { 'name' => gem }
                 end
    [ruby, gem_config]
  end]

default['rbenv']['user_installs'] = [
  { 'user'    => node['bz-server']['user']['name'],
    'rubies'  => node['bz-rails']['rbenv']['rubies'],
    'global'  => node['bz-rails']['rbenv']['rubies'].first,
    'gems'    => gems_config
  }
]

# allow installing global ruby, use include_recipe "rbenv::system" to install it
default['rbenv']['rubies'] = node['bz-rails']['rbenv']['rubies']
default['rbenv']['global'] = node['bz-rails']['rbenv']['rubies'].first
