bz_varnish = default['bz-webserver']['varnish']
bz_varnish['listen_port'] = 80 # listen on 80 by default, nginx should go on 8080 then

# forward attributes to node['varnish']
default['varnish'] = default['varnish'].merge(node['bz-webserver']['varnish'])
