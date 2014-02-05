include_attribute "bz-rails::rbenv"
include_attribute "bz-rails::development_environment" # for ruby version

# init via upstart
default['bz-webserver']['nginx']['init_style'] = "upstart"
default['nginx']['init_style'] = node['bz-webserver']['nginx']['init_style']

# install the following modules
default['bz-webserver']['nginx']['modules'] = %w(
  http_ssl_module
  http_gzip_static_module
  passenger
)
default['nginx']['source']['modules'] = node['bz-webserver']['nginx']['modules']


# passenger configuration
default['bz-webserver']['passenger']['version'] = "4.0.37"
default['nginx']['passenger']['version'] = node['bz-webserver']['passenger']['version']

# rbenv ruby path, something similiar to
# /home/user/.rbenv/versions/2.0.0-p353
default['bz-webserver']['passenger']['ruby_path'] =
  [
    node['rbenv']['root_path'],
    "versions",
    node['bz-rails']['development']['ruby_version'],
  ].join("/")

# passenger gem path, something similiar to
# /home/user/.rbenv/versions/2.0.0-p353/lib/ruby/gems/2.0.0/gems/passenger-3.0
default['bz-webserver']['passenger']['root'] =
  [
    node['bz-webserver']['passenger']['ruby_path'],
    "lib/ruby/gems",
    node['bz-rails']['development']['ruby_gems_version'],
    "gems",
    "passenger-#{node['bz-webserver']['passenger']['version']}"
  ].join("/")

passenger_opts = default['nginx']['passenger']
bz_passenger_opts = default['bz-webserver']['passenger']

passenger_opts['ruby'] = node['bz-webserver']['passenger']['ruby_path']
passenger_opts['root'] = node['bz-webserver']['passenger']['root']

# settings bz defaults
bz_passenger_opts['spawn_method'] = 'smart-lv2'
bz_passenger_opts['buffer_response'] = 'on'
bz_passenger_opts['max_pool_size'] = 6
bz_passenger_opts['min_instances'] = 1
bz_passenger_opts['max_instances_per_app'] = 0
bz_passenger_opts['pool_idle_time'] = 300
bz_passenger_opts['max_requests'] = 0
bz_passenger_opts['gem_binary'] = nil

# overriding nginx defaults with bz ones
bz_passenger_node_opts = node['bz-webserver']['passenger']
passenger_opts['spawn_method'] = bz_passenger_node_opts['spawn_method']
passenger_opts['buffer_response'] = bz_passenger_node_opts['buffer_response']
passenger_opts['max_pool_size'] = bz_passenger_node_opts['max_pool_size']
passenger_opts['min_instances'] = bz_passenger_node_opts['min_instances']
passenger_opts['max_instances_per_app'] = bz_passenger_node_opts['max_instances_per_app']
passenger_opts['pool_idle_time'] = bz_passenger_node_opts['pool_idle_time']
passenger_opts['max_requests'] = bz_passenger_node_opts['max_requests']
passenger_opts['gem_binary'] = bz_passenger_node_opts['gem_binary']
