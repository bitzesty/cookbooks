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
```

This will install passenger and add it's configuration to nginx and
vhost configuration.

**NOTE:** you need to restart nginx after deploying the code first time:
```bash
cd chef
vagrant ssh
sudo service nginx restart
```

#### issues

If you have server with nginx installed the old way and do not want to
reinstall that set node['bz-webserver']['nginx']['force_install_of_nginx_package'] to true

## SSL setup

### Application configuration

In environment.rb file uncomment:

```
config.force_ssl = true
```

### Server configuration

In order to configure ssl you need to:

#### For non production environments generate self signed certificate

##### Generate certificates in cookbook default files

```
cd chef/site-cookbooks/<app>/files/default/
openssl req -x509 -newkey rsa:2048 -keyout <app-env>.key -out <app-env>.crt -days 5000 -nodes

# example
astrauka@KA:/opt/ruby/online-therapy/chef/site-cookbooks/online-therapy/files/default$ openssl req -x509 -newkey rsa:2048 -keyout online-therapy-vagrant.key -out online-therapy-vagrant.crt -days 5000 -nodes
Generating a 2048 bit RSA private key
........................+++
.........................+++
writing new private key to 'online-therapy-vagrant.key'
-----
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [AU]:GB
State or Province Name (full name) [Some-State]:London
Locality Name (eg, city) []:London
Organization Name (eg, company) [Internet Widgits Pty Ltd]:BitZesty
Organizational Unit Name (eg, section) []:
Common Name (e.g. server FQDN or YOUR name) []:online_therapy.app
Email Address []:info@bitzesty.com

# for non default setup the certificates should be named under
node['bz-webserver']['nginx']['certs']['certificate'] (crt)
node['bz-webserver']['nginx']['certs']['key'] (key)
```

#### Add certificate details to node configuration

```json
"bz-webserver": {
  "nginx": {
    "use_ssl": true,
    "ssl_certs_cookbook": "<app-cookbook>"
    "app_configuration_cookbook": <app-cookbook>" # nginx vhost config - defaults to bz-webserver
  }
}
```

##### For non default configuration add

```json
"bz-webserver": {
  "nginx": {
    "certs": {
      "certificate_file_name": "online-therapy-vagrant.crt",
      "key_file_name": "online-therapy-vagrant.key"
    }
  }
}
```

##### For custom list of certificate files

```json
"bz-webserver": {
  "nginx": {
    "certs": {
        "custom_list": true,
        "custom": [
          "schemer-vagrant.crt",
          "schemer-vagrant.pem",
          "schemer-vagrant.key"
        ]
    }
  }
}
```

##### For manual ssl configuration use

```json
"bz-webserver": {
  "nginx": {
    "default_ssl_setup": false
  }
}
```

This will not load the ssl copying and port opening
