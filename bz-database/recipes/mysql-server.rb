include_recipe "database"
include_recipe "database::mysql"

node['mysql']['remove_anonymous_users'] = true # Remove anonymous users
node['mysql']['allow_remote_root'] = false # Root can only login from localhost
node['mysql']['remove_test_database'] = true
node['mysql']['use_upstart'] = true

node['mysql']['server_root_password'] = node['bz-database']['mysql']['root_password'] # Set the server's root password
node['mysql']['server_repl_password'] = node['bz-database']['mysql']['server_repl_password'] # Set the replication user 'repl' password
node['mysql']['server_debian_password'] = node['bz-database']['mysql']['server_debian_password'] # Set the debian-sys-maint user password

include_recipe "mysql::server"

mysql_connection_info = {
  :host => node['bz-database']['mysql']['root_host'],
  :username => node['bz-database']['mysql']['root_user_name'],
  :password => node['bz-database']['mysql']['root_password']
}

node['bz-database']['mysql']['database_names'].each do |db_name|
  # create a mysql database
  mysql_database db_name do
    connection mysql_connection_info

    action :create
  end
end

node['bz-database']['mysql']['users'].each do |user_name, user_params|
  mysql_database_user user_name do
    connection mysql_connection_info

    password user_params[:password]
    action :create
  end


  mysql_database_user user_name do
    connection mysql_connection_info

    database_name user_params[:database]
    host user_params[:grant_host]

    privileges user_params[:privileges]
    action :grant
  end
end
