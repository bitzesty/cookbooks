include_recipe "mongodb"
include_recipe "mongodb::default"

if platform_family? "rhel"
  service "mongod" do
    action [ :enable, :start ]
  end
end
