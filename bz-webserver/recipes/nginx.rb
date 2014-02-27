include_recipe "bz-webserver::common"

case node['platform_family']
when "rhel"
  include_recipe "nginx::package"
when "debian"
  include_recipe "bz-webserver::nginx_debian_package"
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
directory node['bz-webserver']['nginx']['log']['dir'] do
  mode      '0755'
  owner     node['bz-webserver']['nginx']['log']['user']
  group     node['bz-webserver']['nginx']['log']['user']
  action    :create
  recursive true
end

[
  node['bz-webserver']['nginx']['log']['access'],
  node['bz-webserver']['nginx']['log']['error']
].each do |file_location|
  file file_location do
    owner node['bz-server']['user']['name']
    group node['bz-server']['user']['name']
    mode 0644
    action :create_if_missing
  end
end

# create vhost entry
template "/etc/nginx/sites-enabled/#{node['bz-server']['app']['name']}-vhost" do
  source "nginx-vhost.erb"
end

cookbook_file File.join(node['bz-rails']['shared_path'], 'system', 'maintenance.html.bak') do
  source 'maintenance.html.bak'
  owner node['bz-server']['user']['name']
  group node['bz-server']['user']['name']
  mode 0644
  action :create_if_missing
end

# reload configuration and restart nginx
service "nginx" do
  action [:reload, :restart]
end
