bz_varnish = default['bz-webserver']['varnish']
bz_varnish['listen_port'] = 80 # listen on 80 by default, nginx should go on 8080 then
# safe name for file location
user_name = node['bz-server']['user']['name'].gsub(/-/, "_")
bz_varnish['instance'] = user_name
bz_varnish['storage_file'] = "/var/lib/varnish/#{user_name}/varnish_storage.bin"

# forward attributes to node['varnish']
default['varnish'] = default['varnish'].merge(node['bz-webserver']['varnish'])
