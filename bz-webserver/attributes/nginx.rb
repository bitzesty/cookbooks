# opens port 80 for rhel
default['bz-webserver']['open-80-port'] = true

bz_nginx_opts = default['bz-webserver']['nginx']

bz_nginx_opts['use_ssl'] = false
bz_nginx_opts['certs']['dir'] = "#{node['bz-server']['app']['path']}/certs"
bz_nginx_opts['certs']['certificate'] = "#{bz_nginx_opts['certs']['dir']}/#{node['bz-server']['app']['name']}.crt"
bz_nginx_opts['certs']['key'] = "#{bz_nginx_opts['certs']['dir']}/#{node['bz-server']['app']['name']}.key"

bz_nginx_opts['worker_processes'] = "1"
bz_nginx_opts['log_dir'] = "#{node['bz-rails']['shared_path']}/log"
bz_nginx_opts['error_log'] = "#{bz_nginx_opts['log_dir']}/nginx.error.log"
bz_nginx_opts['access_log'] = "#{bz_nginx_opts['log_dir']}/nginx.access.log"
bz_nginx_opts['pid'] = "/var/run/nginx.pid" # in order to change it need to update nginx service conf
