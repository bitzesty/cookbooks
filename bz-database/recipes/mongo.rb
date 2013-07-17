include_recipe "mongodb"
include_recipe "mongodb::default"

if platform_family? "rhel"
  execute "Start mongod on startup" do
    command "chkconfig mongod on"
  end
end
