# rbenv!

# install prequisites
package "build-essential"
package "openssl"
package "libssl-dev"
package "libreadline-dev"

# install rbenv
git "rbenv" do
  repository 'https://github.com/sstephenson/rbenv.git'
  destination node['bz-app']['rbenv']['path']
  user node['bz-app']['user']['name']
  group node['bz-app']['user']['name']
end

# install plugins
directory File.join(node['bz-app']['rbenv']['path'], "plugins") do
  owner node['bz-app']['user']['name']
  group node['bz-app']['user']['name']
end

node['bz-app']['rbenv']['plugins'].each do |repo|
  plugin = repo.match(/([^\/]+)\.git$/)[1]
  git plugin do
    repository repo
    destination File.join(node['bz-app']['rbenv']['path'], "plugins", plugin)
    user node['bz-app']['user']['name']
    group node['bz-app']['user']['name']
  end
end

# install rubies
node['bz-app']['rbenv']['rubies'].each do |ruby|
  execute "rbenv install #{ruby}" do
    command %Q{export PATH=#{node['bz-app']['rbenv']['path']}/bin:$PATH && eval "$(rbenv init -)" && rbenv install #{ruby} && rbenv global #{ruby} && gem install bundler}
    creates File.join(node['bz-app']['rbenv']['path'], "versions", ruby, "bin", "ruby")
    user node['bz-app']['user']['name']
    group node['bz-app']['user']['name']
    environment ({'HOME' => "/home/#{node['bz-app']['user']['name']}"})
  end
end
