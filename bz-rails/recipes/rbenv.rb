# rbenv!

# install prequisites
package "build-essential"
package "openssl"
package "libssl-dev"
package "libreadline-dev"

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

# install rubies
node['bz-rails']['rbenv']['rubies'].each do |ruby|
  execute "rbenv install #{ruby}" do
    command %Q{export PATH=#{node['bz-rails']['rbenv']['path']}/bin:$PATH && eval "$(rbenv init -)" && rbenv install #{ruby} && rbenv global #{ruby} && gem install bundler && rbenv rehash}
    creates File.join(node['bz-rails']['rbenv']['path'], "versions", ruby, "bin", "ruby")
    user node['bz-server']['user']['name']
    group node['bz-server']['user']['name']
    not_if { ::File.exists?("#{node['bz-rails']['rbenv']['path']}/versions/#{ruby}")   }
    environment ({'HOME' => "/home/#{node['bz-server']['user']['name']}"})
  end
end


# add rbenv initializer to bashrc
bashrc_content = %Q{
if [ -d #{node['bz-rails']['rbenv']['path']} ]; then
  export PATH="#{File.join(node['bz-rails']['rbenv']['path'], 'bin')}:$PATH"
  eval "$(rbenv init -)"
fi}

execute "add rbenv to profile" do
  user node['bz-server']['user']['name']
  command "echo 'export PATH=\"$HOME/.rbenv/bin:$PATH\"' >> /home/#{node['bz-server']['user']['name']}/.profile && echo 'eval \"$(rbenv init -)\"' >> /home/#{node['bz-server']['user']['name']}/.profile"
  not_if "cat /home/#{node['bz-server']['user']['name']}/.profile | grep rbenv"
end

execute "add rbenv to bashrc" do
  user node['bz-server']['user']['name']
  command "echo 'export PATH=\"$HOME/.rbenv/bin:$PATH\"' >> /home/#{node['bz-server']['user']['name']}/.bashrc && echo 'eval \"$(rbenv init -)\"' >> /home/#{node['bz-server']['user']['name']}/.bashrc"
  not_if "cat /home/#{node['bz-server']['user']['name']}/.bashrc | grep rbenv"
end
