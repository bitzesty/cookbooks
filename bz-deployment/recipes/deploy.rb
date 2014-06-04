# deploys application via capistrano

# remove commented out code if forwarding ssh keys works
# # ssh certs directory
# directory node['bz-deployment']['ssh_cert_dir'] do
#   mode "700"
#   owner node['bz-server']['user']['name']
#   group node['bz-server']['user']['name']
#   recursive true
# end

# # deploy user rsa key to access github
# cookbook_file "id_rsa" do
#   path node['bz-deployment']['id_rsa_file_path']
#   mode "600"
#   owner node['bz-server']['user']['name']
#   group node['bz-server']['user']['name']
#   cookbook node['bz-deployment']['app_cookbook']
#   action :create
# end

# # ssh configuration
# ssh_config "github.com" do
#   options 'StrictHostKeyChecking' => 'no', 'IdentityFile' => node['bz-deployment']['id_rsa_file_path']
#   user node['bz-server']['user']['name']
# end

# deployment directory to store newest (master) version of the application
directory node['bz-deployment']['deploy_directory'] do
  mode 0755
  owner node['bz-server']['user']['name']
  group node['bz-server']['user']['name']
  recursive true
end

# running via bash forwards ssh key properly
bash "clone project" do
  user node['bz-server']['user']['name']
  group node['bz-server']['user']['name']
  cwd node['bz-deployment']['deploy_directory']
  command %Q{git clone #{node['bz-deployment']['repository']}}
  not_if { ::File.exists?("#{node['bz-deployment']['deploy_app_path']}/Rakefile") }
end

# pull latest code
# running via bash forwards ssh key properly
bash "git pull" do
  user node['bz-server']['user']['name']
  group node['bz-server']['user']['name']
  cwd  node['bz-deployment']['deploy_app_path']
  command %Q{git pull}
end

# bundle
rbenv_script "bundle the new release to be able to run cap deploy" do
  rbenv_version node['bz-rails']['development']['ruby_version']
  code "bundle install"
  group node['bz-server']['user']['name']
  user  node['bz-server']['user']['name']
  cwd node['bz-deployment']['deploy_app_path']
end

rbenv_rehash "Rehash rbenv" do
  user  node['bz-server']['user']['name']
end

# running via bash forwards ssh key properly
bash "deploy" do
  command node['bz-deployment']['deploy_command']
  group node['bz-server']['user']['name']
  user  node['bz-server']['user']['name']
  cwd node['bz-deployment']['deploy_app_path']
  environment node['bz-deployment']['deploy_environment']
end

