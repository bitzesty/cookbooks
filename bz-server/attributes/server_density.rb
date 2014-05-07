sd_attrs = default['bz-server']['serverdensity']
# should specify these
sd_attrs['account'] = nil
sd_attrs['agent_key'] = nil
sd_attrs['token'] = nil
sd_attrs['device_group'] = nil
sd_attrs['mysql_server'] = nil

sd_attrs['mysql_user'] = 'root'
sd_attrs['mysql_pass'] = node['bz-database'].fetch('mysql', {})['root_password']

# forward all attributes to serverdensity
default['serverdensity'] = default['serverdensity'].merge(node['bz-server']['serverdensity'])
