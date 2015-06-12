bz_user = default['bz-server']['user']

# NOTE This probably has to be overriden per app
bz_user['name'] = 'deploy'
bz_user['comment'] = 'deploy'
bz_user['home'] = "/home/#{node['bz-server']['user']['name']}"
bz_user['shell'] = '/bin/bash'

# eg:
#
# bz_user['private_key'] = {
#  "id_dsa" => "key_content"
# }
bz_user['private_key'] = {

}

# eg:
#
# bz_user['private_key'] = {
#  "id_dsa.pub" => "key_content"
# }
bz_user['public_key'] = {

}

bz_user['_default_authorized_keys'] = {
}

# override me for client projects
#
# eg.
# bz_user['authorized_keys'] = {
#  "saulius" => "saulius_public_key_content"
# }

bz_user['authorized_keys'] = {}

bz_user['bitzesty_members'] = [
  "matthewford",
  "hammerfunk",
  "RuslanHamidullin",
  "macool",
  "mauricioac",
  "dreamfall",
  "eritiro"
]
bz_user['authorized_github_users'] = []
bz_user['authorized_users'] = (
  node['bz-server']['user']['bitzesty_members'] +
  node['bz-server']['user']['authorized_github_users']
).uniq
