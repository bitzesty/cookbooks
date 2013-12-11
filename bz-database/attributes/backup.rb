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
config['only_collections'] = node['bz-rails']['database']['only_collections']
config['additional_options'] = node['bz-rails']['database']['additional_options'] || []
config['lock'] = node['bz-rails']['database']['lock'] || false
config['oplog'] = node['bz-rails']['database']['oplog'] || false
# postgres
config = node['bz-database']['backup']['datastore_config']['postgres']
config['name'] = node['bz-rails']['database']['name']
config['username'] = node['bz-rails']['database']['username']
config['password'] = node['bz-rails']['database']['password']
config['host'] = node['bz-rails']['database']['host']
config['port'] = node['bz-rails']['database']['port']
config['socket'] = node['bz-rails']['database']['socket'] || "/tmp/pg.sock"
config['skip_tables'] = node['bz-rails']['database']['skip_tables'] # ['skip', 'tables']
config['only_tables'] = node['bz-rails']['database']['only_tables'] # ["only", "these", "tables"]
config['additional_options'] = node['bz-rails']['database']['additional_options'] || ["-xc", "-E=utf8"]

# backup destination config
# local
default['bz-database']['backup']['storage_config']['local']['path'] = '~/backups'
default['bz-database']['backup']['storage_config']['local']['keep'] = 10
# rackspace
default['bz-database']['backup']['storage_config']['rackspace']['api_key'] = ''
default['bz-database']['backup']['storage_config']['rackspace']['username'] = ''
default['bz-database']['backup']['storage_config']['rackspace']['containeer'] = ''
default['bz-database']['backup']['storage_config']['rackspace']['path'] = ''
default['bz-database']['backup']['storage_config']['rackspace']['keep'] = 10
default['bz-database']['backup']['storage_config']['rackspace']['auth_url'] = ''

# Notifications
node['bz-database']['backup']['hipchat']['token']
node['bz-database']['backup']['hipchat']['rooms_notified']
