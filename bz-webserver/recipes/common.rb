if platform_family?("rhel") && node['bz-webserver']['open-80-port']
  execute "Open firewall port 80 for RHEL" do
    command %Q{iptables -I INPUT -p tcp --dport 80 -j ACCEPT ; service iptables save}
    not_if { `grep "dport 80" /etc/sysconfig/iptables`.include? "80" }
  end
end

if platform_family?("debian")
  include_recipe 'firewall'
  firewall_rule "http" do
    port 80
    action :allow
  end
end
