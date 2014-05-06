log "[ServerDensity] Running scripts"

# install mysql monitoring
if node['bz-server']['serverdensity']['mysql_server']
  log "[ServerDensity] installing mysql server packages"

  case node['platform_family']
  when "debian"
    # required packages
    ["python-dev", "python-mysqldb"].each do |current_package|
      package current_package do
        action :install
      end
    end
  when "rhel"
    # required packages
    ["python-devel", "MySQL-python"].each do |current_package|
      package current_package do
        action :install
      end
    end
  end
end

# install server density
if node['bz-server']['serverdensity']['account']
  log "[ServerDensity] installing alerts"
  include_recipe "serverdensity::alerts"

  # restart server density agent
  service "sd-agent" do
    action :restart
  end
end
