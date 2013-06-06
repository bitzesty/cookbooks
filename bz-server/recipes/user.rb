# Users

user_account node['bz-server']['user']['name'] do
  shell     node['bz-server']['user']['shell']
  comment   node['bz-server']['user']['comment']
  home      "/home/#{node['bz-server']['user']['name']}"
end

# Write predefined private key if present

unless node['bz-server']['user']['private_key'].empty?
  node['bz-server']['user']['private_key'].each { |key_file, key_file_name|
    cookbook_file "/home/#{node['bz-server']['user']['name']}/.ssh/#{key_file}" do
      source key_file_name
      owner node['bz-server']['user']['name']
      group node['bz-server']['user']['name']
      mode  "600"
    end
  }
end

# Write predefined public key if present

unless node['bz-server']['user']['public_key'].empty?
  node['bz-server']['user']['public_key'].each { |key_file, key_file_name|
    cookbook_file "/home/#{node['bz-server']['user']['name']}/.ssh/#{key_file}" do
      source key_file_name
      owner node['bz-server']['user']['name']
      group node['bz-server']['user']['name']
      mode  "644"
    end
  }
end

# user specific templates
%w{bashrc profile}.each do |f|
  template "/home/#{node['bz-server']['user']['name']}/.#{f}" do
    source "#{f}-user.erb"
    owner node['bz-server']['user']['name']
    group node['bz-server']['user']['name']
  end
end

file "/home/#{node['bz-server']['user']['name']}/.gemrc" do
  owner node['bz-server']['user']['name']
  group node['bz-server']['user']['name']
  content "gem: --no-rdoc --no-ri\n"
end

directory "/home/#{node['bz-server']['user']['name']}/.bundle" do
  mode "755"
  owner node['bz-server']['user']['name']
  group node['bz-server']['user']['name']
end

# for security..
directory "/home/#{node['bz-server']['user']['name']}/.ssh" do
  mode "700"
  owner node['bz-server']['user']['name']
  group node['bz-server']['user']['name']
end

file "/home/#{node['bz-server']['user']['name']}/.ssh/authorized_keys" do
  owner node['bz-server']['user']['name']
  group node['bz-server']['user']['name']
  mode "600"
  content node['bz-server']['user']['_default_authorized_keys'].merge(node['bz-server']['user']['authorized_keys']).values.join("\n")
end

service "dbus" do
  action [:enable, :start]
end
