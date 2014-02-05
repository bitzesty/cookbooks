# installs and configures nginx, adds passenger module

# installs system wide rbenv
include_recipe "rbenv::system"

# install rake and passenger for system wide ruby to compile nginx and run passenger
rbenv_gem "rake" do
  rbenv_version node['bz-rails']['development']['ruby_version']
  action        :install
end

rbenv_gem "passenger" do
  version       node['bz-webserver']['passenger']['version']
  rbenv_version node['bz-rails']['development']['ruby_version']
  action        :install
end

include_recipe "nginx"

execute 'install passenger on nginx' do
  command "passenger-install-nginx-module" <<
    " --auto" <<
    " --prefix=/etc/nginx" <<
    " --extra-configure-flags='--with-http_ssl_module --with-http_gzip_static_module'"
  not_if do
    File.exists?("#{node['bz-webserver']['passenger']['root']}/agents/PassengerWatchdog")
  end
end
