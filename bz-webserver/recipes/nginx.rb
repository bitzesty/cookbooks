if platform_family?("rhel") && node['bz-webserver']['open-80-port']
  execute "Open firewall port 80 for RHEL" do
    command %Q{iptables -I INPUT -p tcp --dport 80 -j ACCEPT ; service iptables save}
    not_if { `grep "dport 80" /etc/sysconfig/iptables`.include? "80" }
  end
end

include_recipe "nginx"

template "/etc/nginx/sites-enabled/#{node['bz-server']['app']['name']}-vhost" do
  source "nginx-vhost.erb"
  notifies :reload, "service[nginx]", :immediately
end

