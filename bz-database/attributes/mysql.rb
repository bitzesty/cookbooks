include_attribute "bz-server::app"

default['bz-database']['mysql']['database_name'] = node['bz-server']['app']['name']
default['bz-database']['mysql']['database_host'] = 'localhost'
default['bz-database']['mysql']['database_username'] = node['bz-server']['app']['name']
default['bz-database']['mysql']['database_password'] = 'thisissomerandompassword1'
default['bz-database']['mysql']['privileges'] = [:all]
default['bz-database']['mysql']['grant_host'] = 'localhost'

# general info

default['bz-database']['mysql']['root_user_name'] = 'root'
default['bz-database']['mysql']['root_password'] = 'thisissomerandompassword1'
default['bz-database']['mysql']['server_repl_password'] = 'thisissomerandompassword2'
default['bz-database']['mysql']['server_debian_password'] = 'thisissomerandompassword3'
