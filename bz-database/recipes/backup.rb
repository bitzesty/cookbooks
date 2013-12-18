# install backup gem
# uses rbenv
execute "install backup gem" do
  command %Q{export PATH=#{node['bz-rails']['rbenv']['path']}/bin:$PATH && eval "$(rbenv init -)" && gem install backup && rbenv rehash}
  creates File.join(node['bz-rails']['rbenv']['path'], "shims", "backup")
  user node['bz-server']['user']['name']
  group node['bz-server']['user']['name']
  environment ({'HOME' => "/home/#{node['bz-server']['user']['name']}"})
end

# create backup directory structure
dirs_to_create = [
  File.join(node['bz-server']['user']['home'], 'Backup'),
  File.join(node['bz-server']['user']['home'], 'Backup', 'log'),
  File.join(node['bz-server']['user']['home'], 'Backup', 'data'),
  File.join(node['bz-server']['user']['home'], 'Backup', 'models')
]

dirs_to_create.flatten.compact.each do |directory_name|
  directory directory_name do
    mode 0755
    owner node['bz-server']['user']['name']
    group node['bz-server']['user']['name']
    recursive true
  end
end

# create configs
template File.join(node['bz-server']['user']['home'], 'Backup', 'config.rb') do
  source "backup-config.rb.erb"
  owner node['bz-server']['user']['name']
  group node['bz-server']['user']['name']
end

template File.join(node['bz-server']['user']['home'],
                   'Backup',
                   'models',
                   "#{node['bz-server']['app']['name']}.rb") do
  source "backup-models.rb.erb"
  owner node['bz-server']['user']['name']
  group node['bz-server']['user']['name']
end

# setup cron job
cron "DB backup for #{node['bz-server']['app']['name']}" do
  hour "1"
  minute "5"
  command "/bin/bash -l -c 'backup perform --trigger #{node['bz-server']['app']['name']} 2> #{File.join(node['bz-server']['user']['home'], 'Backup', node['bz-server']['app']['name'] + '_error.log')}'"
  user node['bz-server']['user']['name']
end
