# installs and configures nginx, adds passenger module

# install default nginx, will reuse upstart and common web server configuration
include_recipe "bz-webserver::nginx"

# install passenger to compile nginx and run passenger
rbenv_gem "passenger" do
  version       node['bz-webserver']['passenger']['version']
  rbenv_version node['bz-rails']['development']['ruby_version']
  user          node['bz-server']['user']['name']
  action        :install
end

# install passenger nginx if not installed yet
execute 'install passenger with nginx' do
  command "bash -c \"source #{node['bz-rails']['rbenv']['bashrc_path']}" <<
    " && #{node['bz-webserver']['passenger']['ruby_path']}/bin/passenger-install-nginx-module" <<
    " --auto" <<
    " --prefix=/etc/nginx" <<
    " --auto-download" <<
    " --extra-configure-flags='#{node['bz-webserver']['passenger']['conf_flags']}'\""

  creates "#{node['bz-webserver']['passenger']['root']}/buildout/agents/PassengerWatchdog"
  retries 2
  timeout 36000
end

# stop passenger via service
service "nginx" do
  action :stop
end

# kill passenger nginx if still alive,
# we need to update it's configuration and manage via service
execute "kill passenger nginx" do
  command "sudo pkill nginx || echo 0" # ensure we return 0
end

# create log dir
directory node['bz-webserver']['passenger']['log_dir'] do
  mode      '0755'
  owner     node['nginx']['user']
  action    :create
  recursive true
end

# update service nginx configuration
template node['bz-webserver']['passenger']['nginx_daemon_config'] do
  source "nginx_init_d.erb"
end

# update global nginx configuration
template "/etc/nginx/conf/nginx.conf" do
  source "nginx.conf.erb"
end

# passenger conf
template "#{node['bz-webserver']['passenger']['dir']}/conf.d/passenger.conf" do
  source "passenger.conf.erb"
  owner "root"
  group "root"
  mode "0644"
end

# make sure nginx gets restarted
service "nginx" do
  action :reload
end
