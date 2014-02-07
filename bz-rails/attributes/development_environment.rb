include_attribute "bz-server::app"

dev_params = default['bz-rails']['development']
dev_params['path'] = "#{node['bz-server']['app']['path']}_dev"
dev_params['db_config_path'] = "#{dev_params['path']}/config"

dev_params['db_config_file_path'] =
  case node['bz-rails']['database']['type']
  when 'mongodb'
    "#{dev_params['db_config_path']}/mongoid.yml"
  else
    "#{dev_params['db_config_path']}/database.yml"
  end

dev_params['db_config_example_file_path'] = "#{dev_params['db_config_file_path']}.example"

dev_params['ruby_version'] = node['bz-rails']['rbenv']['rubies'].first

ruby_gems_version = dev_params['ruby_version'].split("-").first
if ["1.9.2", "1.9.3"].include?(ruby_gems_version)
  ruby_gems_version = "1.9.1" # as per http://stackoverflow.com/questions/8564210/why-are-we-installing-ruby-1-9-2-1-9-3-gems-into-a-1-9-1-folder
end
dev_params['ruby_gems_version'] = ruby_gems_version
