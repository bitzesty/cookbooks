include_attribute "bz-rails::rbenv"
include_attribute "bz-rails::development_environment" # for ruby version

bz_passenger_opts = default['bz-webserver']['passenger']
bz_passenger_node_opts = node['bz-webserver']['passenger']

# install the following modules with passenger
bz_passenger_opts['conf_flags'] = "--with-http_ssl_module --with-http_gzip_static_module"
bz_passenger_opts['version'] = "4.0.37"

# rbenv ruby path, something similiar to
# /home/tss/.rbenv/versions/2.0.0-p353
bz_passenger_opts['ruby_path'] =
  [
    node['bz-rails']['rbenv']['path'],
    "versions",
    node['bz-rails']['development']['ruby_version'],
  ].join("/")

bz_passenger_opts['ruby'] =
  [
    node['bz-webserver']['passenger']['ruby_path'],
    "bin/ruby",
  ].join("/")

# passenger gem path, something similiar to
# /home/tss/.rbenv/versions/2.0.0-p353/lib/ruby/gems/2.0.0/gems/passenger-3.0
bz_passenger_opts['root'] =
  [
    node['bz-webserver']['passenger']['ruby_path'],
    "lib/ruby/gems",
    node['bz-rails']['development']['ruby_gems_version'],
    "gems",
    "passenger-#{node['bz-webserver']['passenger']['version']}",
  ].join("/")


# nginx paths
bz_passenger_opts['dir'] = '/etc/nginx'
bz_passenger_opts['script_dir'] = "#{bz_passenger_opts['dir']}/sbin"
bz_passenger_opts['binary'] = "#{bz_passenger_opts['script_dir']}/nginx"
bz_passenger_opts['log_dir'] = "#{node['bz-server']['user']['home']}/nginx/log"
bz_passenger_opts['nginx_daemon_config'] = "/etc/init.d/nginx"

# nginx conf
bz_passenger_opts['user'] = node['bz-server']['user']['name']
bz_passenger_opts['worker_processes'] = "1"
bz_passenger_opts['error_log'] = "#{bz_passenger_opts['log_dir']}/error.log"
bz_passenger_opts['access_log'] = "#{bz_passenger_opts['log_dir']}/access.log"
bz_passenger_opts['pid'] = "/var/run/nginx.pid" # in order to change it need to update nginx service conf

# passenger conf
bz_passenger_opts['spawn_method'] = 'smart-lv2'
bz_passenger_opts['buffer_response'] = 'on'
bz_passenger_opts['max_pool_size'] = 6
bz_passenger_opts['min_instances'] = 1
bz_passenger_opts['max_instances_per_app'] = 0
bz_passenger_opts['pool_idle_time'] = 300
bz_passenger_opts['max_requests'] = 0
bz_passenger_opts['gem_binary'] = nil
bz_passenger_opts['default_user'] = node['bz-server']['user']['name']
