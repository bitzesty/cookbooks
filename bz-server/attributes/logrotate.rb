# enable logrotate by default
default['bz-server']['logrotate']['enabled'] = true

# max file size for logs
default['bz-server']['logrotate']['max_size'] = "100MB"
