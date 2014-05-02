# opens port 80 for rhel
default['bz-webserver']['open-80-port'] = true

bz_nginx_opts = default['bz-webserver']['nginx']

bz_nginx_opts['force_install_of_nginx_package'] = false
bz_nginx_opts['use_ssl'] = false
bz_nginx_opts['default_ssl_setup'] = true
bz_nginx_opts['ports']['http'] = 80
bz_nginx_opts['ports']['ssl'] = 443
bz_nginx_opts['certs']['dir'] = "#{node['bz-server']['app']['path']}/certs"
bz_nginx_opts['certs']['certificate_file_name'] = "#{node['bz-server']['app']['name']}-#{node['bz-rails']['environment']}.crt"
bz_nginx_opts['certs']['key_file_name'] = "#{node['bz-server']['app']['name']}-#{node['bz-rails']['environment']}.key"
bz_nginx_opts['certs']['certificate'] = "#{bz_nginx_opts['certs']['dir']}/#{node['bz-webserver']['nginx']['certs']['certificate_file_name']}"
bz_nginx_opts['certs']['key'] = "#{bz_nginx_opts['certs']['dir']}/#{node['bz-webserver']['nginx']['certs']['key_file_name']}"
bz_nginx_opts['app_configuration_cookbook'] = "bz-webserver"
bz_nginx_opts['ssl_certs_cookbook'] = "" # should be overriden with application cookbook

bz_nginx_opts['worker_processes'] = "1"
bz_nginx_opts['client_max_body_size'] = "10m"
bz_nginx_opts['log']['dir'] = "#{node['bz-rails']['shared_path']}/log"
bz_nginx_opts['log']['error'] = "#{bz_nginx_opts['log']['dir']}/nginx.error.log"
bz_nginx_opts['log']['access'] = "#{bz_nginx_opts['log']['dir']}/nginx.access.log"
bz_nginx_opts['log']['user'] = node['bz-server']['user']['name']
bz_nginx_opts['pid'] = "/var/run/nginx.pid" # in order to change it need to update nginx service conf

bz_nginx_opts['restart'] = "/etc/init.d/nginx restart"
