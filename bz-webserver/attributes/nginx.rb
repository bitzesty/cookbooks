# opens port 80 for rhel
default['bz-webserver']['open-80-port'] = true

bz_nginx_opts = default['bz-webserver']['nginx']

bz_nginx_opts['worker_processes'] = "1"
bz_nginx_opts['log_dir'] = "#{node['bz-server']['user']['home']}/nginx/log"
bz_nginx_opts['error_log'] = "#{bz_nginx_opts['log_dir']}/error.log"
bz_nginx_opts['access_log'] = "#{bz_nginx_opts['log_dir']}/access.log"
bz_nginx_opts['pid'] = "/var/run/nginx.pid" # in order to change it need to update nginx service conf
