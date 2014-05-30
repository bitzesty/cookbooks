# will try to avoid by adding the key to ansible server
# deploy key to be able to fetch repositories
# scp .ssh/id_rsa sxt_hiv@sxt_hiv.app:/home/sxt_hiv/.ssh/id_rsa_deploy

# fetch repository, we will deploy via capistrano from it
mkdir -p /home/sxt_hiv/deployment
cd /home/sxt_hiv/deployment

# unless sxt-hiv folder exists
git clone git@github.com:bitzesty/sxt-hiv.git

cd sxt-hiv

# checkout newest code
git pull

bundle

HIPCHAT_TOKEN=94fcb0db90a76e9e61f4965a1f2f83 bundle exec cap vagrant deploy
