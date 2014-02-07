bz-webserver Cookbook
===============
Cookbook for preparing web server part

Requirements
------------
Installs and configures nginx and optionnally passenger

Usage
-----
#### bz-webserver::nginx

Include `bz-webserver::nginx` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[bz-webserver::nginx]"
  ]
}
```

#### passenger

##### into node configuration

```json
{
  "bz-server": {
    "app": {
      "rails_app_server": "passenger"
    }
  }
}
"recipe[bz-rails::development_environment]"
```

This will install passenger and add it's configuration to nginx and
vhost configuration.

**NOTE:** you need to restart nginx after deploying the code first time:
```bash
cd chef
vagrant ssh
sudo service nginx restart
```
