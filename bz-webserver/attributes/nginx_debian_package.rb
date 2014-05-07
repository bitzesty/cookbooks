default['webserver']['nginx']['apt_key'] = "561F9B9CAC40B2F7"

bz_passenger_opts = default['bz-webserver']['passenger']
bz_passenger_node_opts = node['bz-webserver']['passenger']

# taken from passenger package installation
bz_passenger_opts['root'] = "/usr/lib/ruby/vendor_ruby/phusion_passenger/locations.ini"
bz_passenger_opts['ruby'] = "/home/schemer/.rbenv/shims/ruby"
bz_passenger_opts['min_instances'] = 2
