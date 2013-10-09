# Install packages

# ensure apt sources are updated
if platform_family? "debian"
  include_recipe "apt"
end

node['bz-server']['_default_packages'].each do |pkg|
  package "installing package: #{pkg}" do
    package_name pkg
  end
end

node['bz-server']['packages'].each do |pkg|
  package "installing package: #{pkg}" do
    package_name pkg
  end
end

