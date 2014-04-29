bz-rails Cookbook
===============
Cookbook for preparing rails environment for the application

Requirements
------------
Uses rbenv for ruby installation

Usage
-----
#### bz-rails::rails

##### into run list

```json
{
  "run_list": [
    "recipe[bz-rails::rails]",
    "recipe[bz-rails::rbenv]"
  ]
}
```

##### into node configuration

```json
"bz-rails": {

  # to configure ENV variables
  "env": {
    "KEY": "VALUE"
  },
}
```

#### development via vagrant

##### into run list

```json
"recipe[bz-rails::development_environment]"
```

## Examples

Mongoid configuration example

```json
"bz-rails": {
  "environment": "production",
  "rbenv": {
    "rubies": ["1.9.3-p429"]
  },
  "database": {
    "type": "mongodb",
    "name": "qavs_production",
    "hosts": [
      "localhost:27017"
    ],
    "consistency": ":strong",
    "options": {
      "allow_dynamic_fields": false,
      "preload_models": true,
      "scope_overwrite_exception": true,
      "use_utc": true
    }
  }
}
```

