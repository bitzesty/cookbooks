bz_passenger_opts = default['bz-webserver']['passenger']
bz_passenger_node_opts = node['bz-webserver']['passenger']

bz_passenger_opts['apt_key'] = "561F9B9CAC40B2F7"

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

# # user passenger gem path, something similiar to
# # /home/tss/.rbenv/versions/2.0.0-p353/lib/ruby/gems/2.0.0/gems/passenger-3.0
# bz_passenger_opts['root'] =
#   [
#     node['bz-webserver']['passenger']['ruby_path'],
#     "lib/ruby/gems",
#     node['bz-rails']['development']['ruby_gems_version'],
#     "gems",
#     "passenger-#{node['bz-webserver']['passenger']['version']}",
#   ].join("/")
