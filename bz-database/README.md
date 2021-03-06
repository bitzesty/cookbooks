bz-database Cookbook
===============
This cookbook wraps database receipes to easily setup database and user
for rails database.

Usage
-----
#### bz-database

Currently supported databases: mysql, mongodb, postgres

##### Mongoid configuration example

```json
"bz-database": {
  "mongoid": {
  }
}

"run_list": [
  "recipe[bz-database::mongo]"
]
```

##### Postgres configuration example

```json
"bz-database": {
  "postgres": {
    "password": "generate a password SecureRandom.base64"
  }
}

"run_list": [
  "recipe[bz-database::postgres]"
]
```

#### Redis

##### into run list

```json
"recipe[bz-database::redis]"
```

##### into berksfile

```
cookbook 'redisio', github: 'brianbianco/redisio'
```

#### Backup

For rackspace storage create the following containers in rackspace cloud:

```
database
```

##### into run list

```json
"recipe[bz-database::backup]"
```

##### configuration examples

General

```json
"bz-database": {
  "backup": {
    "split_into_chunks": true,
    "encrypt": true,
    "encryptor": "openssl",
    "encryptor_config": {
      "openssl": {
        "password":"generate a password SecureRandom.base64",
        "base64": true,
        "salt": true
      }
    },
    "hipchat": {
      "token": "",
      "rooms_notified": []
    }
  }
}
```

Storage

```json
"bz-database": {
  "backup": {
    "storage": "rackspace",
    "storage_config": {
      "rackspace": {
        "username": "user",
        "api_key": "key",
        "container": "database", # default
        "segments_container": "database_segments", # default
        "path": "backups", # default
        "keep": "10", # default
        "auth_url": "https://lon.identity.api.rackspacecloud.com/v2.0" # default
      }
    }
  }
}
```

```json
"bz-database": {
  "backup": {
    "storage_config": {
      "local": {
        "path": "~/backups", # default
        "keep": "10", # default
      }
    }
  }
}
```

By default storage is local unless rackspace specified

MySql

```json
"bz-database": {
  "backup": {
    "datastore_config": {
      "mysql": {
        "port": 3306, # set default already
        "command_options": ["--quick", "--single-transaction"] # set default already
      }
    }
  }
}

Postgres

```json
"bz-database": {
  "backup": {
    "datastore_config": {
      "postgres": {
        "skip_tables": [], # set default already
        "only_tables": [], # set default already
        "additional_options": ["-xc", "-E=utf8"] # set default already
      }
    }
  }
}

Mongo

```json
"bz-database": {
  "backup": {
    "datastore_config": {
      "mongo": {
        "only_collections": [], # set default already
        "lock": false, # set default already
        "oplog": false, # set default already
        "additional_options": ["-xc", "-E=utf8"] # set default already
      }
    }
  }
}
```

Restore data from backups
------------

* Check ```/home/<app_user>/Backup/models/<app_name>/config.rb``` for backup location.
* Download the backup if needed. They are stored by date.
* Extract it: ```tar xvf <app_name>.tar```
* ```cd <app_name>/databases```
* ```gunzip <file>.gz```
* restore as per database:
  * postgres
  ```psql dbname < file```

Requirements
------------
TODO: List your cookbook requirements. Be sure to include any requirements this cookbook has on platforms, libraries, other cookbooks, packages, operating systems, etc.

e.g.
#### packages
- `toaster` - bz-database needs toaster to brown your bagel.

Attributes
----------
TODO: List you cookbook attributes here.

e.g.
#### bz-database::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['bz-database']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

Contributing
------------
TODO: (optional) If this is a public cookbook, detail the process for contributing. If this is a private cookbook, remove this section.

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: TODO: List authors
