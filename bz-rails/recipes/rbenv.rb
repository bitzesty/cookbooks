# rbenv!

# install prequisites
if platform_family? "debian"
  package "build-essential"
  package "openssl"
  package "libssl-dev"
  package "libreadline-dev"
end

# install rbenv
git "rbenv" do
  repository 'https://github.com/sstephenson/rbenv.git'
  destination node['bz-rails']['rbenv']['path']
  user node['bz-server']['user']['name']
  group node['bz-server']['user']['name']
end

# install plugins
directory File.join(node['bz-rails']['rbenv']['path'], "plugins") do
  owner node['bz-server']['user']['name']
  group node['bz-server']['user']['name']
end

node['bz-rails']['rbenv']['plugins'].each do |repo|
  plugin = repo.match(/([^\/]+)\.git$/)[1]
  git plugin do
    repository repo
    destination File.join(node['bz-rails']['rbenv']['path'], "plugins", plugin)
    user node['bz-server']['user']['name']
    group node['bz-server']['user']['name']
  end
end

# add rbenv initializer to bashrc
bashrc_content = %Q{
export PATH="#{File.join(node['bz-rails']['rbenv']['path'], 'bin')}:$PATH"
eval "$(rbenv init -)"
}

execute "add rbenv to profile" do
  user node['bz-server']['user']['name']
  command "echo '#{bashrc_content}' >> /home/#{node['bz-server']['user']['name']}/.profile"
  not_if "cat /home/#{node['bz-server']['user']['name']}/.profile | grep rbenv"
end

execute "add rbenv to bashrc" do
  user node['bz-server']['user']['name']
  command "echo '#{bashrc_content}' >> /home/#{node['bz-server']['user']['name']}/.bashrc"
  not_if "cat /home/#{node['bz-server']['user']['name']}/.bashrc | grep rbenv"
end

# install rubies
node['bz-rails']['rbenv']['rubies'].each do |ruby|
  execute "rbenv install #{ruby}" do
    user node['bz-server']['user']['name']
    command %Q{exec $SHELL -l && rbenv install #{ruby} && rbenv global #{ruby} && gem install bundler && rbenv rehash}
    creates File.join(node['bz-rails']['rbenv']['path'], "versions", ruby, "bin", "ruby")
    not_if { ::File.exists?("#{node['bz-rails']['rbenv']['path']}/versions/#{ruby}")   }
  end
end


