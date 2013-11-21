# should be set in node configuration file
default['java']['install_flavor'] = node['bz-server']['java']['install_flavor']
default['java']['jdk_version'] = node['bz-server']['java']['jdk_version']
default['elasticsearch']['cluster_name'] = node['bz-server']['elasticsearch']['cluster_name']

default['elasticsearch']['bootstrap.mlockall'] = node['bz-server']['elasticsearch']['bootstrap.mlockall'] || false
