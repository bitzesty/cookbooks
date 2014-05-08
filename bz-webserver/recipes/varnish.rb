# package via their repository
include_recipe "varnish::apt_repo"

# install varnish
include_recipe "varnish::default"

# open admin port
port = node['varnish']['admin_listen_port'].to_s
if platform_family?("rhel")
  execute "Open firewall port #{port} for RHEL" do
    command %Q{iptables -I INPUT -p tcp --dport #{port} -j ACCEPT ; service iptables save}
    not_if { `grep "dport #{port}" /etc/sysconfig/iptables`.include? port }
  end
end

if platform_family?("debian")
  firewall_rule "varnish_admin" do
    port port.to_i
    action :allow
  end
end
