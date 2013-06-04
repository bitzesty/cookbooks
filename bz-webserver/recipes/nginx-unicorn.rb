template "/etc/nginx/sites-enabled/#{node[:app][:name]}-vhost" do
  source "nginx-vhost.erb"
  notifies :reload, "service[nginx]", :immediately
end
