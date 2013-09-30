ENV['LANGUAGE'] = ENV['LANG'] = ENV['LC_ALL'] = node[:locale][:lang]
include_recipe "postgresql::server"
include_recipe "database::postgresql"

db_connection_info = {
  :host => node['bz-rails']['database']['host'],
  :port => node['bz-rails']['database']['port'],
  :username => node['bz-database']['postgres']['username'],
  :password => node['bz-database']['postgres']['password']
}

database_user node['bz-rails']['database']['username'] do
  provider Chef::Provider::Database::PostgresqlUser
  connection db_connection_info
  password node['bz-rails']['database']['password']
  action :create
end

postgresql_database node['bz-rails']['database']['name'] do
  connection db_connection_info
  owner node['bz-rails']['database']['username']
  encoding node['bz-rails']['database']['encoding']
  action :create
end
