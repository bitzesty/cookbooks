# installs and configures nginx, adds passenger module

# installs required gems via rbenv
rbenv_gem "rake" do
  rbenv_version node['bz-rails']['development']['ruby_version']
  action        :install
  user  node['bz-server']['user']['name']
end

rbenv_gem "passenger" do
  version       node['nginx']['passenger']['version']
  rbenv_version node['bz-rails']['development']['ruby_version']
  action        :install
  user  node['bz-server']['user']['name']
end

include_recipe "nginx"
