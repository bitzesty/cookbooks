default['webserver']['nginx']['apt_key'] = "561F9B9CAC40B2F7"

bz_passenger_opts = default['bz-webserver']['passenger']
bz_passenger_node_opts = node['bz-webserver']['passenger']

# taken from passenger package installation
bz_passenger_opts['root'] = "/usr/lib/ruby/vendor_ruby/phusion_passenger/locations.ini"

# rbenv ruby path, something similiar to
# /home/tss/.rbenv/versions/2.0.0-p353
bz_passenger_opts['ruby_path'] =
  [
    node['bz-rails']['rbenv']['path'],
    "versions",
    node['bz-rails']['development']['ruby_version'],
  ].join("/")

# ruby binary location, something similiar to
# /home/tss/.rbenv/versions/2.0.0-p353/bin/ruby
bz_passenger_opts['ruby'] =
  [
    node['bz-webserver']['passenger']['ruby_path'],
    "bin/ruby",
  ].join("/")
