file File.join(node['bz-rails']['shared_path'], 'public', 'system', 'maintenance.html') do
  owner node['bz-server']['user']['name']
  group node['bz-server']['user']['name']
  mode 0644
  content ::File.open(File.join(node['bz-rails']['shared_path'], 'public', 'system', 'maintenance.html.bak')).read
  action :create
end
