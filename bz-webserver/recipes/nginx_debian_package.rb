# install nginx and optionally passenger from repository

# add repository
apt_repository 'nginx_passenger' do
  uri       "https://oss-binaries.phusionpassenger.com/apt/passenger"
  key       node['bz-webserver']['nginx']['apt_key']
  distribution node['bz-server']['ubuntu_release']
  components ["main"]
  retries 2
end

# following http://www.modrails.com/documentation/Users%20guide%20Nginx.html#install_on_debian_ubuntu
# add apt-key, apt cookbook does not support --recv-keys option
execute "passenger: add apt-key" do
  command "sudo apt-key adv" <<
          " --keyserver keyserver.ubuntu.com:80" <<
          " --recv-keys #{node['bz-webserver']['passenger']['apt_key']}"
  not_if "apt-key list | grep #{node['bz-webserver']['passenger']['apt_key']}"
end

execute "update apt to have passenger among packages" do
  command "apt-get -y update"
  not_if "dpkg -s passenger"
end

# install packages
nginx_packages = %w(nginx-extras)
if node['bz-server']['app']['rails_app_server'] == "passenger"
  # passenger must be installed before nginx
  nginx_packages.unshift "passenger"
end

nginx_packages.each do |package|
  apt_package package do
    action :install
    options "--force-yes"
  end
end

# register service
service 'nginx' do
  supports :status => true, :restart => true, :reload => true
  action   :enable
end

# allow user to restart nginx for passenger
if node['bz-server']['app']['rails_app_server'] == "passenger"
  sudo node['bz-server']['user']['name'] do
    user node['bz-server']['user']['name']
    commands [
      node['bz-webserver']['nginx']['restart']
    ]
    host "ALL"
    nopasswd true
  end
end
