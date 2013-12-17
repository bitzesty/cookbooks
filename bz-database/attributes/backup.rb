default['bz-database']['backup']['split_into_chunks'] = false
default['bz-database']['backup']['chunk_size'] = '250' # in mb

default['bz-database']['backup']['encrypt'] = false
default['bz-database']['backup']['encryptor'] = 'openssl'
default['bz-database']['backup']['encryptor_config']['openssl']['password'] = ''
default['bz-database']['backup']['encryptor_config']['openssl']['base64'] = true
default['bz-database']['backup']['encryptor_config']['openssl']['salt'] = true

default['bz-database']['backup']['storage'] = 'local'
default['bz-database']['backup']['datastore'] = ''
default['bz-database']['backup']['compress'] = 'gzip'

# datastore configuration
# mysql
config = default['bz-database']['backup']['datastore_config']['mysql']
config['database'] = node['bz-rails']['database']['name']
config['username'] = node['bz-rails']['database']['username']
config['password'] = node['bz-rails']['database']['password']
config['host'] = node['bz-rails']['database']['host']
config['port'] = 3306
config['command_options'] = ["--quick", "--single-transaction"]
# mongo
config = default['bz-database']['backup']['datastore_config']['mongo']
config['name'] = node['bz-rails']['database']['name']
config['username'] = node['bz-rails']['database']['username']
config['password'] = node['bz-rails']['database']['password']
config['host'] = node['bz-rails']['database']['host']
config['port'] = node['bz-rails']['database']['host']
config['ipv6'] = node['bz-rails']['database']['ipv6'] || false
config['only_collections'] = []
config['additional_options'] = []
config['lock'] = false
config['oplog'] = false
# postgres
config = node['bz-database']['backup']['datastore_config']['postgres']
config['name'] = node['bz-rails']['database']['name']
config['username'] = node['bz-rails']['database']['username']
config['password'] = node['bz-rails']['database']['password']
config['host'] = node['bz-rails']['database']['host']
config['port'] = node['bz-rails']['database']['port']
config['socket'] = node['bz-rails']['database']['socket'] || "/tmp/pg.sock"
config['skip_tables'] = []
config['only_tables'] = []
config['additional_options'] = ["-xc", "-E=utf8"]

# backup destination config
# local
config = default['bz-database']['backup']['storage_config']['local']
config['path'] = '~/backups'
config['keep'] = 10
# rackspace
config = default['bz-database']['backup']['storage_config']['rackspace']
config['api_key'] = ''
config['username'] = ''
config['containeer'] = ''
config['path'] = ''
config['keep'] = 10
config['auth_url'] = ''

# Notifications
config = node['bz-database']['backup']['hipchat']
config['token'] = ""
config['rooms_notified'] = []
