# Install packages

node['bz-app']['_default_packages'].each do |pkg|
  package pkg
end

node['bz-app']['packages'].each do |pkg|
  package pkg
end

