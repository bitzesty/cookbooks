include_attribute "bz-server::app"

default[:mongodb][:bind_ip] = '127.0.0.1'

# available attributes
# https://github.com/edelight/chef-mongodb/blob/master/attributes/default.rb
