# create new database.yml
if node['bz-rails']['environment'] &&
    node['bz-rails']['database']['type'] &&
    node['bz-rails']['database']['name']
  case node['bz-rails']['database']['type']
  when 'mysql', 'mysql2', 'postgresql'
    template File.join(node['bz-rails']['shared_path'], 'config', 'database.yml') do
      source "database.yml.erb"
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
    template File.join(node['bz-rails']['shared_path'], 'config', 'mongoid.yml') do
      source "mongoid.yml.erb"
      owner node['bz-server']['user']['name']
      group node['bz-server']['user']['name']
      mode 0644
      variables({
        :environment => node['bz-rails']['environment'],
        :database => node['bz-rails']['database']['name'],
        :hosts => node['bz-rails']['database']['hosts'],
        :consistency => node['bz-rails']['database']['consistency'],
        :allow_dynamic_fields => node['bz-rails']['database']['options']['allow_dynamic_fields'],
        :preload_models => node['bz-rails']['database']['options']['preload_models'],
        :scope_overwrite_exception => node['bz-rails']['database']['options']['scope_overwrite_exception'],
        :use_utc => node['bz-rails']['database']['options']['use_utc']
      })
    end
  end
end
