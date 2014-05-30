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
  "astrauka",
  "hammerfunk",
  "matthewford",
  "RuslanHamidullin",
  "macool",
  "mauricioac",
  "rodzyn",
  "bzcibot"
]
bz_user['authorized_github_users'] = []
bz_user['authorized_users'] = (
  node['bz-server']['user']['bitzesty_members'] +
  node['bz-server']['user']['authorized_github_users']
).uniq


# # fetch bitzesty organization members from github
# bz_user['members']['path'] = "https://api.github.com/orgs/bitzesty/members"
# bz_user['members']['params'] = "access_token=<access token>"
# bz_user['members']['url'] = [
#   node['bz-server']['user']['members']['path'],
#   node['bz-server']['user']['members']['params']
# ].join("?")

# to implement users from github:
# require 'net/http'
# require 'json'
# uri = URI(node['bz-server']['user']['members']['url'])
# users = JSON.parse(Net::HTTP.get(uri))
# user_names = user.map{ |user| user["login"] }
# To do that we need to ensure to not expose access token publically
