# install nginx and passenger from repository,
# Even if you do not use passenger, this gives the latest nginx

# following http://www.modrails.com/documentation/Users%20guide%20Nginx.html#install_on_debian_ubuntu
# add apt-key
execute "passenger: add apt-key" do
  command "apt-key adv" <<
          " --keyserver hkp://keyserver.ubuntu.com:80" <<
          " --recv-keys #{node['bz-webserver']['passenger']['apt_key']}"
  not_if "apt-key list | grep #{node['bz-webserver']['passenger']['apt_key']}"
end

# add to source list
template "/etc/apt/sources.list.d/passenger.list" do
  source "passenger.list.erb"
  group "root"
  owner "root"
  mode  "600"
  notifies :run, 'execute[apt-get update]', :immediately
end

# install packages
%w(nginx-extras passenger).each do |package|
  apt_package package do
    action :install
  end
end

# register service
service 'nginx' do
  supports :status => true, :restart => true, :reload => true
  action   :enable
end
