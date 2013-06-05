include_recipe "nginx"

template "/etc/nginx/sites-enabled/#{node['bz-server']['app']['name']}-vhost" do
  source "nginx-vhost.erb"
  notifies :reload, "service[nginx]", :immediately
end
