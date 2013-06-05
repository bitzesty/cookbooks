include_recipe "database"

include_recipe "mysql::server"
include_recipe "mysql::client"

node['mysql']['remove_anonymous_users'] = true # Remove anonymous users
node['mysql']['allow_remote_root'] = false # Root can only login from localhost
node['mysql']['remove_test_database'] = true

node['mysql']['server_root_password'] = '' # Set the server's root password
node['mysql']['server_repl_password'] = '' # Set the replication user 'repl' password
node['mysql']['server_debian_password'] = '' # Set the debian-sys-maint user password

# create a mysql database
mysql_database 'oracle_rules' do
  connection ({:host => "localhost", :username => 'root', :password => node['mysql']['server_root_password']})
  action :create
end
