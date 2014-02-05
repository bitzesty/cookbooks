include_attribute "bz-rails::rbenv"

default['nginx']['passenger']['version'] = "4.0.37"

# rbenv ruby path, something similiar to
# /home/user/.rbenv/versions/2.0.0-p353
default['bz-webserver']['passenger']['ruby_path'] =
  [
    node['bz-rails']['rbenv']['path'],
    "versions",
    node['bz-rails']['rbenv']['rubies'].first,
  ].join("/")

# passenger gem path, something similiar to
# /home/user/.rbenv/versions/2.0.0-p353/lib/ruby/gems/2.0.0/gems/passenger-3.0
default['bz-webserver']['passenger']['root'] =
  [
    node['bz-webserver']['passenger']['ruby_path'],
    "lib/ruby/gems",
    node['bz-rails']['rbenv']['rubies'].first.split("-").first,
    "gems",
    "passenger-#{node['bz-webserver']['passenger']['version']}"
  ].join("/")

passenger_opts = default['nginx']['passenger']
bz_passenger_opts = default['bz-webserver']['passenger']

passenger_opts['ruby'] = node['bz-webserver']['passenger']['ruby_path']
passenger_opts['root'] = node['bz-webserver']['passenger']['root']

passenger_opts['spawn_method'] = bz_passenger_opts['spawn_method'] ||= 'smart-lv2'
passenger_opts['buffer_response'] = bz_passenger_opts['buffer_response'] ||= 'on'
passenger_opts['max_pool_size'] = bz_passenger_opts['max_pool_size'] ||= 6
passenger_opts['min_instances'] = bz_passenger_opts['min_instances'] ||= 1
passenger_opts['max_instances_per_app'] = bz_passenger_opts['max_instances_per_app'] ||= 0
passenger_opts['pool_idle_time'] = bz_passenger_opts['pool_idle_time'] ||= 300
passenger_opts['max_requests'] = bz_passenger_opts['max_requests'] ||= 0
passenger_opts['gem_binary'] = bz_passenger_opts['gem_binary'] ||= nil
