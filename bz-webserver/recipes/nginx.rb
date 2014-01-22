include_recipe "bz-webserver::common"

include_recipe "nginx"

file "/etc/nginx/sites-enabled/default" do
  action :delete
end

template "/etc/nginx/sites-enabled/#{node['bz-server']['app']['name']}-vhost" do
  source "nginx-vhost.erb"
  notifies :reload, "service[nginx]", :immediately
end

