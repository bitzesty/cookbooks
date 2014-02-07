include_recipe "bz-webserver::common"

case node['platform_family']
when "rhel"
  include_recipe "nginx::package"
when "debian"
  include_recipe "bz-webserver::passenger_package"
end

# update nginx confirguration
template "/etc/nginx/nginx.conf" do
  source "nginx.conf.erb"
end

# remove default site configuration
file "/etc/nginx/sites-enabled/default" do
  action :delete
end

# create log dir
directory node['bz-webserver']['nginx']['log_dir'] do
  mode      '0755'
  owner     node['nginx']['user']
  action    :create
  recursive true
end

# create vhost entry
template "/etc/nginx/sites-enabled/#{node['bz-server']['app']['name']}-vhost" do
  source "nginx-vhost.erb"
end

# restart nginx
service "nginx" do
  action :reload
end
