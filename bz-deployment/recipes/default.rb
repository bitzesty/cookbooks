# will try to avoid by adding the key to ansible server
# deploy key to be able to fetch repositories
# scp .ssh/id_rsa sxt_hiv@sxt_hiv.app:/home/sxt_hiv/.ssh/id_rsa_deploy

# ssh_cert_source_path = "#{node['bz-rails']['development']['path']}/chef/site-cookbooks/#{node['bz-server']['app']['name']}/files/default/id_rsa.pub"
ssh_cert_dir = "/home/#{node['bz-server']['user']['name']}/.ssh"

directory ssh_cert_dir do
  mode "700"
  owner node['bz-server']['user']['name']
  group node['bz-server']['user']['name']
  recursive true
end

# directory ssh_cert_dir do
#   mode "700"
#   owner node['bz-server']['user']['name']
#   group node['bz-server']['user']['name']
#   action :create
# end

cookbook_file "id_rsa" do
  path "#{ssh_cert_dir}/id_rsa_deploy"
  mode "600"
  owner node['bz-server']['user']['name']
  group node['bz-server']['user']['name']
  cookbook node['bz-deployment']['app_configuration_cookbook']
  action :create_if_missing
end

# mkdir -p /home/sxt_hiv/deployment
directory_name = "/home/#{node['bz-server']['user']['name']}/deployment"
directory directory_name do
  mode 0755
  owner node['bz-server']['user']['name']
  group node['bz-server']['user']['name']
  recursive true
end

# cd /home/sxt_hiv/deployment
# unless sxt-hiv folder exists
# git clone git@github.com:bitzesty/sxt-hiv.git
clone_path = "/home/#{node['bz-server']['user']['name']}/deployment"

git "#{clone_path}/#{node['bz-server']['app']['name']}" do
  user node['bz-server']['user']['name']
  group node['bz-server']['user']['name']
  repository "git@github.com:bitzesty/#{node['bz-server']['app']['name']}.git"
  action :checkout
  not_if { ::File.exists?("#{clone_path}/#{node['bz-server']['app']['name']}") }
end

# cd sxt-hiv
# checkout newest code
# git pull
execute "go to cloned app, bundle and deploy" do
  user node['bz-server']['user']['name']
  group node['bz-server']['user']['name']
  cwd "#{clone_path}/#{node['bz-server']['app']['name']}"
  command "git pull && bundle && HIPCHAT_TOKEN=#{node['bz-database']['backup']['hipchat']['token']} bundle exec cap #{node['bz-rails']['environment']} deploy"
end