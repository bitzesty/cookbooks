# this basically does cap deploy:cold and creates structure

dirs_to_create = [
  "#{node['bz-server']['user']['home']}/.init",
  node['bz-server']['app']['path'],
  node['bz-rails']['shared_path'],
  node['bz-rails']['releases_path']]

dirs_to_create << node['bz-rails']['_default_shared_directories'].map { |dir_name|
  File.join("#{node['bz-rails']['shared_path']}", dir_name)
}
dirs_to_create << node['bz-rails']['shared_directories'].map { |dir_name|
  File.join("#{node['bz-rails']['shared_path']}", dir_name)
}

dirs_to_create.flatten.compact.each do |directory_name|
  directory directory_name do
    mode 0755
    owner node['bz-server']['user']['name']
    group node['bz-server']['user']['name']
    recursive true
  end
end

include_recipe "bz-rails::database_config"

# TODO setup log rotate etc
