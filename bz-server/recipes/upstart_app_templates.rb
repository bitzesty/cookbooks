# Setup upstart templates for starting app as a service via user jobs

# create directory
directory node['bz-server']['upstart_templates']['path'] do
  owner node['bz-server']['user']['name']
  group node['bz-server']['user']['name']
  mode 0755
  action :create
  recursive true
end

# copy templates
%w(master process process_master).each do |upstart_template|
  cookbook_file File.join(node['bz-server']['upstart_templates']['path'], "#{upstart_template}.conf.erb") do
    owner node['bz-server']['user']['name']
    group node['bz-server']['user']['name']
    mode 0644
    action :create
  end
end
