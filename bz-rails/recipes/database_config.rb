# create new database.yml
if node['bz-rails']['environment'] &&
    node['bz-rails']['database']['type'] &&
    node['bz-rails']['database']['name'] &&
    node['bz-rails']['database']['username']
  case node['bz-rails']['database']['type']
  when 'mysql', 'mysql2', 'postgresql'
    template File.join(node['bz-rails']['shared_path'], 'config', 'database.yml') do
      source "database.yml.#{node['bz-rails']['database']['type']}.erb"
      owner node['bz-server']['user']['name']
      group node['bz-server']['user']['name']
      mode 0644
      variables({
        :environment => node['bz-rails']['environment'],
        :adapter => node['bz-rails']['database']['type'],
        :database => node['bz-rails']['database']['name'],
        :username => node['bz-rails']['database']['username'],
        :password => node['bz-rails']['database']['password'],
        :host => node['bz-rails']['database']['host']
      })
    end
  when 'mongodb'
    # implement it for mongodb
  end
end
