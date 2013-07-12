# Setup for things that need to happen before server provision can occur

include_recipe "ubuntu"

# Hosts file management
if node['bz-server']['ip_address'] && node['bz-server']['domain']
  hostsfile_entry "Adding host file for #{node['bz-server']['ip_address']}" do
    ip_address node['bz-server']['ip_address']
    hostname node['bz-server']['domain']
    aliases node['bz-server']['aliases']
    action :create_if_missing
  end
end

hostsfile_entry 'Adding host file for 127.0.0.1' do
  ip_address '127.0.0.1'
  hostname 'localhost'
  action :create_if_missing
end
