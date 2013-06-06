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
  'saulius' => 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDEtZ1HUT6H1JvM/DBcTozscGjcameyaTJncZHELZNYoWEDwKAc+Zrvjy0mD6jEZunt1tKUZjA+Vnlycy3HzF91p4zml8JBLMqoSzzjp1xi8OAxR9IedmTEvKkmEpe7pql2TvCaKd1YfcraKLZsETIjtHiZ24nZ3q4Dq2vZBAnzMXmntkLDnaklQ91twTWCaNsVf+8P8kQgglnzhIaWrIorb3cZilP//z4SckiUxlBt5fAXwJQfktFH5ZGqIoUlBV0TRI/VLPcGv46ULnVxUhlkI2kNS5vxti1ar6IpQi0gWimjfQPrV7Au1Pq/fe8se6MkFPVqgp9iPMY9Vpk+IPW/'
}

# override me for client projects
#
# eg.
# default['bz-server']['user']['authorized_keys'] = {
#  "saulius" => "saulius_public_key_content"
# }

default['bz-server']['user']['authorized_keys'] = {}
