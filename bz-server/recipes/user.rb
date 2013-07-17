# Users

user_account node['bz-server']['user']['name'] do
  shell     node['bz-server']['user']['shell']
  comment   node['bz-server']['user']['comment']
  home      "/home/#{node['bz-server']['user']['name']}"
  ssh_keygen false
end

# Write predefined public private key if present

node['bz-server']['ssh_keys']['users'].each do |user, config|
  ssh_dir = "/home/#{user}/.ssh"

  directory ssh_dir do
    mode "700"
    owner user
    group user
    recursive true
  end

  config.each do |name, key|
    file "#{ssh_dir}/#{name}" do
      content key.join("\n")
      owner user
      group user
      mode name.match(/\.pub$/) ? 00644 : 00600
    end
  end
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

unless node['bz-server']['user']['authorized_github_users'].empty?
  require 'open-uri'

  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

  node['bz-server']['user']['authorized_github_users'].each do |github_user|
    user_keys = open("https://github.com/#{github_user}.keys").read
    user_keys.split("\n").each_with_index { |key, index|
      # NOTE uses Hashie::Mash
      node.default['bz-server']['user']['authorized_keys'].send("#{github_user}_github_#{index}=", key.strip)
    }
  end
end

file "/home/#{node['bz-server']['user']['name']}/.ssh/authorized_keys" do
  owner node['bz-server']['user']['name']
  group node['bz-server']['user']['name']
  mode "600"
  content node['bz-server']['user']['_default_authorized_keys'].to_hash.merge(node['bz-server']['user']['authorized_keys'].to_hash).map{ |comment, key| "#{key} #{comment}" }.join("\n")
end

if platform_family? "rhel"
  execute "restore ssh conf to include authorized keys" do
    command "restorecon -R -v /home/#{node['bz-server']['user']['name']}/.ssh"
  end
end

dbus_service = if platform_family? "rhel"
                 "messagebus"
               else
                 "dbus"
               end

service "#{dbus_service}" do
  action [:enable, :start]
end
