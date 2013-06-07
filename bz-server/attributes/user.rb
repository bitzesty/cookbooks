# NOTE This probably has to be overriden per app
default['bz-server']['user']['name'] = 'deploy'
default['bz-server']['user']['comment'] = 'deploy'
default['bz-server']['user']['home'] = "/home/#{node['bz-server']['user']['name']}"
default['bz-server']['user']['shell'] = '/bin/bash'

# eg:
#
# default['bz-server']['user']['private_key'] = {
#  "id_dsa" => "key_content"
# }
default['bz-server']['user']['private_key'] = {

}

# eg:
#
# default['bz-server']['user']['private_key'] = {
#  "id_dsa.pub" => "key_content"
# }
default['bz-server']['user']['public_key'] = {

}

default['bz-server']['user']['_default_authorized_keys'] = {
}

# override me for client projects
#
# eg.
# default['bz-server']['user']['authorized_keys'] = {
#  "saulius" => "saulius_public_key_content"
# }

default['bz-server']['user']['authorized_keys'] = {}
