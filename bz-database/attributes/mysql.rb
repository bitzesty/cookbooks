include_attribute "bz-server::app"

default['bz-database']['mysql']['database_names'] = [
  node['bz-server']['app']['name']
]

# eg
#
# default['bz-database']['mysql']['users'] = {
#   user_name: {
#     password: "somepassword",
#     privileges: ['all'],
#     database: 'lol',
#     grant_host: 'localhost'
#   }
# }
default['bz-database']['mysql']['users'] = {
}

# general info

default['bz-database']['mysql']['version'] = '5.5'

default['bz-database']['mysql']['root_user_name'] = 'root'
default['bz-database']['mysql']['root_host'] = 'localhost'
default['bz-database']['mysql']['root_password'] = 'thisissomerandompassword1'
default['bz-database']['mysql']['server_repl_password'] = 'thisissomerandompassword2'
default['bz-database']['mysql']['server_debian_password'] = 'thisissomerandompassword3'
default['bz-database']['mysql']['socket'] = "/var/run/mysqld/mysqld.sock"
