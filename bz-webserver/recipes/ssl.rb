# directory for certs
directory node['bz-webserver']['nginx']['certs']['dir'] do
  owner node['bz-server']['user']['name']
  group node['bz-server']['user']['name']
  mode 0755
  recursive true
end

# add certs
#   for user defined list of certs
cert_files =
  if node['bz-webserver']['nginx']['certs']['custom_list']
    node['bz-webserver']['nginx']['certs']['custom'].map do |name|
      File.join(node['bz-webserver']['nginx']['certs']['dir'], name)
    end
  else
    [
      node['bz-webserver']['nginx']['certs']['certificate'],
      node['bz-webserver']['nginx']['certs']['key']
    ]
  end

#   for default certificate and key
cert_files.each do |cert_file|
  if cert_file.empty? || node['bz-webserver']['nginx']['ssl_certs_cookbook'].empty?
    raise "Please define the following in ['bz-webserver']['nginx']: ['certs']['certificate'], ['certs']['key'], ['ssl_certs_cookbook']"
  else
    cookbook_file cert_file do
      backup 5
      owner node['bz-server']['user']['name']
      group node['bz-server']['user']['name']
      mode 0644
      cookbook node['bz-webserver']['nginx']['ssl_certs_cookbook']
    end
  end
end

# open port
if platform_family?("rhel")
  port = node['bz-webserver']['nginx']['ports']['ssl'].to_s
  execute "Open firewall port #{port} for RHEL" do
    command %Q{iptables -I INPUT -p tcp --dport #{port} -j ACCEPT ; service iptables save}
    not_if { `grep "dport #{port}" /etc/sysconfig/iptables`.include? port }
  end
end

if platform_family?("debian")
  firewall_rule "https" do
    port node['bz-webserver']['nginx']['ports']['ssl']
  end
end
