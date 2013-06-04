# Setup for things that need to happen before server provision can occur

# Update repositories the system
execute "apt-get-update" do
  user "root"
  command "apt-get update"
end

