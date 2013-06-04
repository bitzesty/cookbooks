# Setup for things that need to happen before server provision can occur


include_recipe "ubuntu"
include_recipe "locales" # set to en_US.UTF-8

# Update repositories the system
execute "apt-get-update" do
  user "root"
  command "apt-get update"
end
