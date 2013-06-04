# Users

user_account node['bz-app']['user']['name'] do
  shell     node['bz-app']['user']['shell']
  comment   node['bz-app']['user']['comment']
  home      "/home/#{node['bz-app']['user']['name']}"
  ssh_keygen node['bz-app']['user']['ssh-keygen']
end


# user specific templates
%w{bashrc profile}.each do |f|
  template "/home/#{node['bz-app']['user']['name']}/.#{f}" do
    source "#{f}-user.erb"
    owner node['bz-app']['user']['name']
    group node['bz-app']['user']['name']
  end
end

file "/home/#{node['bz-app']['user']['name']}/.gemrc" do
  owner node['bz-app']['user']['name']
  group node['bz-app']['user']['name']
  content "gem: --no-rdoc --no-ri\n"
end

directory "/home/#{node['bz-app']['user']['name']}/.bundle" do
  mode "755"
  owner node['bz-app']['user']['name']
  group node['bz-app']['user']['name']
end

# for security..
directory "/home/#{node['bz-app']['user']['name']}/.ssh" do
  mode "700"
  owner node['bz-app']['user']['name']
  group node['bz-app']['user']['name']
end

file "/home/#{node['bz-app']['user']['name']}/.ssh/authorized_keys" do
  owner node['bz-app']['user']['name']
  group node['bz-app']['user']['name']
  mode "600"
  content node['bz-app']['user']['_default_authorized_keys'].merge(node['bz-app']['user']['authorized_keys']).values.join("\n")
end

service "dbus" do
  action [:enable, :start]
end

template "/etc/dbus-1/system.d/Upstart.conf" do
  source "Upstart.erb"
  owner "root"
  group "root"
  mode  "644"
  notifies :reload, "service[dbus]", :immediately
end
