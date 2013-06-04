# NOTE This probably has to be overriden per app
default['bz-server']['user']['name'] = 'deploy'
default['bz-server']['user']['comment'] = 'deploy'
default['bz-server']['user']['shell'] = '/bin/bash'
default['bz-server']['user']['ssh-keygen'] = true
default['bz-server']['user']['_default_authorized_keys'] = {
  'saulius' => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDEtZ1HUT6H1JvM/DBcTozscGjcameyaTJncZHELZNYoWEDwKAc+Zrvjy0mD6jEZunt1tKUZjA+Vnlycy3HzF91p4zml8JBLMqoSzzjp1xi8OAxR9IedmTEvKkmEpe7pql2TvCaKd1YfcraKLZsETIjtHiZ24nZ3q4Dq2vZBAnzMXmntkLDnaklQ91twTWCaNsVf+8P8kQgglnzhIaWrIorb3cZilP//z4SckiUxlBt5fAXwJQfktFH5ZGqIoUlBV0TRI/VLPcGv46ULnVxUhlkI2kNS5vxti1ar6IpQi0gWimjfQPrV7Au1Pq/fe8se6MkFPVqgp9iPMY9Vpk+IPW/'
}

# override me for client projects
default['bz-server']['user']['authorized_keys'] = {}
