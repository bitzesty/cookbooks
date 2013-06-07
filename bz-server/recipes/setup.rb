# Setup for things that need to happen before server provision can occur

include_recipe "ubuntu"
include_recipe "locales" # set to en_US.UTF-8

locales "en_US.UTF-8 UTF-8" do
  action :add
end

# locale configuration
[
  "LANG=en_US.UTF-8",
  "LANGUAGE=en_US:en",
  "LC_CTYPE=en_US.UTF-8",
  "LC_NUMERIC=en_US.UTF-8",
  "LC_TIME=en_US.UTF-8",
  "LC_COLLATE=en_US.UTF-8",
  "LC_MONETARY=en_US.UTF-8",
  "LC_MESSAGES=en_US.UTF-8",
  "LC_PAPER=en_US.UTF-8",
  "LC_NAME=en_US.UTF-8",
  "LC_ADDRESS=en_US.UTF-8",
  "LC_TELEPHONE=en_US.UTF-8",
  "LC_MEASUREMENT=en_US.UTF-8",
  "LC_IDENTIFICATION=en_US.UTF-8"].each do |locale_line|

  ruby_block "insert_line" do
    block do
      file = Chef::Util::FileEdit.new("/etc/default/locale")
      file.insert_line_if_no_match("/#{locale_line}/", locale_line)
      file.write_file
    end
  end
end

# Hosts file management
if node['bz-server']['ip_address'] && node['bz-server']['domain']
  hostsfile_entry node['bz-server']['ip_address'] do
    hostname node['bz-server']['domain']
    aliases node['bz-server']['aliases']
    action :create_if_missing
  end
end

hostsfile_entry '127.0.0.1' do
  ip_address '127.0.0.1'
  hostname 'localhost'
  action :create_if_missing
end
