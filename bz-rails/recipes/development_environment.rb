# sets up development and test environment
# the source code is synced via vagrant synced folder: http://docs.vagrantup.com/v2/synced-folders/basic_usage.html
# Syncing can de added adding to your project Vagrantfile the following lines:
#  vagrant_development_path = "/home/#{SETTINGS["bz-server"]["user"]["name"]}/#{SETTINGS["bz-server"]["app"]["name"]}_dev"
#  config.vm.network :private_network, ip: SETTINGS["bz-server"]["ip_address"]
#  # grant max permissions as bz-server user is not created on initial machine setup
#  config.vm.synced_folder "..",
#                          vagrant_development_path,
#                          create: true,
#                          mount_options: ['dmode=777', 'fmode=666']


# make sure database configuration present
file node['bz-rails']['development']['db_config_file_path'] do
  group node['bz-server']['user']['name']
  owner node['bz-server']['user']['name']
  mode 0755
  content ::File.open(node['bz-rails']['development']['db_config_example_file_path']).read
  action :create_if_missing
end

rbenv_script "development env: bundle install" do
  rbenv_version node['bz-rails']['development']['ruby_version']
  code "bundle install"
  group node['bz-server']['user']['name']
  user  node['bz-server']['user']['name']
  cwd node['bz-rails']['development']['path']
end

# create rbenv plugins directory
directory node['bz-rails']['development']['rbenv_plugins_path'] do
  owner node['bz-server']['user']['name']
  group node['bz-server']['user']['name']
  mode 0755
  action :create
end

# checkout the rbenv binstubs gem
git "#{node['bz-rails']['development']['rbenv_plugins_path']}/rbenv-binstubs" do
  repository node['bz-rails']['development']['rbenv_binstubs_repo']
  reference "master"
  action :checkout
end

rbenv_script "development env: create binstubs for the application" do
  rbenv_version node['bz-rails']['development']['ruby_version']
  code "bundle install --binstubs .bundle/bin"
  group node['bz-server']['user']['name']
  user  node['bz-server']['user']['name']
  cwd node['bz-rails']['development']['path']
end

rbenv_rehash "Rehash rbenv" do
  user  node['bz-server']['user']['name']
end

rbenv_script "development env: create development database and seed" do
  rbenv_version node['bz-rails']['development']['ruby_version']
  code "RAILS_ENV=development spring rake db:create db:migrate db:seed"
  group node['bz-server']['user']['name']
  user  node['bz-server']['user']['name']
  cwd node['bz-rails']['development']['path']
end

rbenv_script "development env: create test database" do
  rbenv_version node['bz-rails']['development']['ruby_version']
  code "RAILS_ENV=test spring rake db:migrate"
  group node['bz-server']['user']['name']
  user  node['bz-server']['user']['name']
  cwd node['bz-rails']['development']['path']
end
