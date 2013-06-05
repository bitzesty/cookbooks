include_recipe "database"
include_recipe "database::mysql"

node['mysql']['remove_anonymous_users'] = true # Remove anonymous users
node['mysql']['allow_remote_root'] = false # Root can only login from localhost
node['mysql']['remove_test_database'] = true

node['mysql']['server_root_password'] = node['bz-database']['mysql']['root_password'] # Set the server's root password
node['mysql']['server_repl_password'] = node['bz-database']['mysql']['server_repl_password'] # Set the replication user 'repl' password
node['mysql']['server_debian_password'] = node['bz-database']['mysql']['server_debian_password'] # Set the debian-sys-maint user password

include_recipe "mysql::server"

mysql_connection_info = {
  :host => node['bz-database']['mysql']['database_host'],
  :username => node['bz-database']['mysql']['root_user_name'],
  :password => node['bz-database']['mysql']['root_password']
}

# create a mysql database
mysql_database node['bz-database']['mysql']['database_name'] do
  connection mysql_connection_info

  action :create
end

mysql_database_user node['bz-database']['mysql']['database_username'] do
  connection mysql_connection_info

  password node['bz-database']['mysql']['database_password']
  action :create
end


mysql_database_user node['bz-database']['mysql']['database_username'] do
  connection mysql_connection_info

  database_name node['bz-database']['mysql']['database_name']
  host node['bz-database']['mysql']['grant_host']

  privileges node['bz-database']['mysql']['privileges']
  action :grant
end
