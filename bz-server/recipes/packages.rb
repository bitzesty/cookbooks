# Install packages

node['bz-server']['_default_packages'].each do |pkg|
  package pkg
end

node['bz-server']['packages'].each do |pkg|
  package pkg
end

