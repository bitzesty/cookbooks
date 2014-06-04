# deploys application via capistrano

# ssh certs directory
directory node['bz-deployment']['ssh_cert_dir'] do
  mode "700"
  owner node['bz-server']['user']['name']
  group node['bz-server']['user']['name']
  recursive true
end

# deploy user rsa key to access github
cookbook_file "id_rsa" do
  path node['bz-deployment']['id_rsa_file_path']
  mode "600"
  owner node['bz-server']['user']['name']
  group node['bz-server']['user']['name']
  cookbook node['bz-deployment']['app_cookbook']
  action :create
end

# deployment directory to store newest (master) version of the application
directory node['bz-deployment']['deploy_directory'] do
  mode 0755
  owner node['bz-server']['user']['name']
  group node['bz-server']['user']['name']
  recursive true
end

# ssh configuration
ssh_config "github.com" do
  options 'StrictHostKeyChecking' => 'git', 'IdentityFile' => node['bz-deployment']['id_rsa_file_path']
  user node['bz-server']['user']['name']
end

# clone/checkout the project
git node['bz-deployment']['deploy_app_path'] do
  user node['bz-server']['user']['name']
  group node['bz-server']['user']['name']
  repository node['bz-deployment']['repository']
  revision node['bz-deployment']['checkout_branch']
  action :sync
end

# bundle
rbenv_script "bundle the new release to be able to run cap deploy" do
  rbenv_version node['bz-rails']['development']['ruby_version']
  code "bundle install"
  group node['bz-server']['user']['name']
  user  node['bz-server']['user']['name']
  cwd node['bz-deployment']['deploy_directory']
end

rbenv_rehash "Rehash rbenv" do
  user  node['bz-server']['user']['name']
end

# deploy
rbenv_script "deploy" do
  rbenv_version node['bz-rails']['development']['ruby_version']
  code node['bz-deployment']['deploy_command']
  group node['bz-server']['user']['name']
  user  node['bz-server']['user']['name']
  cwd node['bz-deployment']['deploy_directory']
  environment node['bz-deployment']['deploy_environment']
end
