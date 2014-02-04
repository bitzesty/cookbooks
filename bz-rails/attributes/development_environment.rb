include_attribute "bz-server::app"

dev_params = default['bz-rails']['development']
dev_params['path'] = "#{node['bz-server']['app']['path']}_dev"
dev_params['db_config_path'] = "#{dev_params['path']}/config"

dev_params['db_config_file_path'] =
  case node['bz-database']['backup']['datastore']
  when 'mongodb'
    "#{dev_params['db_config_path']}/mongoid.yml"
  else
    "#{dev_params['db_config_path']}/database.yml"
  end

dev_params['db_config_example_file_path'] = "#{dev_params['db_config_file_path']}.example"

dev_params['bashrc_path'] = "#{node['bz-server']['user']['home']}/.bashrc"
dev_params['ruby_version'] = node['bz-rails']['rbenv']['rubies'].first
