# Changelog

## Master

## 0.2.16

Fixing various issues with new dependencies and conflicts

* Switched from 'cloud_monitoring' to 'rackspace_cloudmonitoring'
* Updated 'apt' from '2.6.0' to '2.7.0'
* Updated 'database' from '2.3.0' to '3.0.0'
* Set 'firewall' coobooks to "~1.3.0"
* Corrected 'firewall' related condition in bz-webserver/recipes/common.rb

## 0.2.16

* Bump new version

## 0.2.14

* Updated users

## 0.2.13

* Added support for newer version of berkshelf, by removing `github` option from some of the cookbook paths
* Added firewall cookbook dependency for the webserver cookbook, so it works on newer versions of Berkshelf
* Upgrading postgresql cookbook to work better with the database cookbook

## 0.2.12

  * `bz-server::logrotate`: set max file size to 100MB by default for logrotate

## 0.2.11

* Added security options to nginx.conf.erb:

```
more_clear_headers 'Server';
more_clear_headers 'X-Powered-By';
more_clear_headers 'X-Runtime';
```

* Updated 'mysql' from '5.5.2' to '5.6.1'

* Removed setting of the version for cookbook 'serverdensity'
  as it raises error while running "berks update"
```
The cookbook downloaded for serverdensity (= 2.0.0) did not satisfy the constraint.
```

## 0.2.10

* Updated 'redisio' from '2.2.3' to '2.2.4'
* Updated 'apt' from '2.4.0' to '2.6.0'
* Updated 'nginx' from '2.7.0' to '2.7.4'
* Replaced 'nginx-extra' with 'nginx-full' (as it causes 'shared memory' issue in some envs)
* Set 'varnish' cookbook to use bitzesty's fork
* Disabled using of custom 'storage_file' in bz-webserver/attributes/varnish.rb for time being (see https://github.com/rackspace-cookbooks/varnish/issues/39)

## 0.2.9

* Updated 'redisio' from '1.7.1' to '2.2.3'

## 0.2.8

* Updated 'mysql' from '5.4.4' to '5.5.2'

## 0.2.7

* Updated 'database' from '2.2.1' to '2.3.0'
* Updated 'mysql' from '5.3.6' to '5.4.4'

## 0.2.6

* NGINX: fixed issue with displaying "Welcome NGINX" page for some non ubuntu platforms.
  For example: Centos use Nginx on EPEL, which populates /etc/nginx/conf.d/default.conf
  So, it will be loaded at first, because in bz-webserver/templates/default/nginx.conf.erb
  we have following lines:
  ```
    include /etc/nginx/conf.d/*.conf;
    include /etc/nginx/sites-enabled/*;
  ```

## 0.2.5

* NGINX: fixed issue with user www-data option in nginx.conf.erb, which caused on Centos
  Original issue description: https://tickets.opscode.com/browse/COOK-3397?page=com.atlassian.jira.plugin.system.issuetabpanels:comment-tabpanel
* Updated 'ubuntu' cookbook from "1.1.7" to "1.1.8"

## 0.2.1

* removed bzcibot

## 0.2.0

* Added jaleszek and removed astrauka

## 0.1.32

* Add `bzcibot` to `bitzesty_members`

## 0.1.31

* **bz-webserver** maintenance page update

## 0.1.30

* **bz-webserver** update nginx configuration
* **bz-database** always reinstall backup gem

## 0.1.29

* **bz-webserver** add varnish

## 0.1.28

* **bz-server** add server density monitoring

## 0.1.27

* **all** update cookbook versions to newest ones

## 0.1.26

* **bz-webserver** allow more automatic ssl setup
* **bz-database** do not add socket to database configuration if that's
  not defined as blank socket makes the dump to not get the host properly

## 0.1.25

* **bz-database** lock backup gem version to ~> 3, update backup configuration generation

## 0.1.24

* **bz-server** upstart templates are managed by chef

## 0.1.23

* **bz-webserver** update nginx cookbook version

## 0.1.22

* **bz-server** add logrotate, enable by default

## 0.1.21

* **all** fetch metadata and Berksfile.in from github
* **all** added more guys to default loaded github users that will auth
  on server
* **bz-webserver** update nginx cookbook version

## 0.1.20

* **bz-server** define github users to allow provisioning machines

* **bz-webserver** allow user to restart nginx once using passenger

## 0.1.19

* **bz-webserver** update nginx configuration with passenger, ssl and
  maintenance page support

## 0.1.18

* **bz-rails** setup spring for development environment

## 0.1.17

* **chef** suggesting to use 11.6.2 version

* **bz-webserver** installs nginx with (optionally) passenger from debian packages.
  The installation ensures you always have the newest nginx version

* **all** use Berksfile.in to properly load dependent gems from bz cookbooks

## 0.1.16

* **bz-rails** sets up development environment

## 0.1.15

* **bz-rails** make dotenv support more Capistrano 3 compatible

## 0.1.14

* **bz-rails** support for passing ENVironment variables to server
  processes based on foreman/dotenv

## 0.1.13

* **bz-database** added database backup

## 0.1.12

* **bz-rails** add more attrbiutes to mongoid configuration

## 0.1.11

* **bz-server** added unattended_upgrades recipe, installed by default for debian machines

## 0.1.10

* **bz-server** added elasticsearch recipe, not installed by default

## 0.1.9

* **bz-server** added imagemagick to be installed by default

## 0.1.8

* redis is now part of `bz-database`, include `bz-database::redis` to
  have it present in the server
* redis is not installed by default
* port 80 is opened in firewall whenever webserver is installed, see
  `bz-webserver::common` (support for ubuntu and rhel for now)

## 0.1.7 add redis installation cookbook
* **bz-server** add redis

## 0.1.6 add rackspace support
* **all** add rackspace support

## 0.1.5 add postgres database and update rbenv installation
* **bz-database** add postgres database
* **bz-rails** use community cookbook for ruby and rbenv installation


## 0.1.4 configuration for CentOs (astrauka)

* **bz-database** start mongod on system startup
* **bz-webserver** open firewall port 80 for http
* **bz-server** use system jobs for application server management, allow the user to start/stop app with sudo start app / sudo stop app
* **bz-server** restore ssh configuration to include authorized keys

### fixes

* **bz-database** rename mondodb recipe to mongo
* **bz-rails** do not require username to be defined to build database config

## 0.1.3

* **all** Added support for mongodb (astrauka)
* **all** Added support for CentOS (astrauka)

### fixes

* **bz-rails** Fix rbenv ruby installations with proper check of existence (sauliusg)
* Added README

## 0.1.2

* **all** Added Chef 11 compatibility (tested with 11.4.2) (sauliusg)
* **bz-server** Added locale management recipe compatible with Chef 11 (sauliusg)

## 0.1.1

* **bz-server** Added support for user pubkey fetching from GitHub (sauliusg). E.g.:

    ```
    {
      "bz-server": {
        "user": {
          "authorized_github_users": [
            "sauliusg",
            "astrauka",
            "hammerfunk",
            "Aaron2Ti",
            "matthewford"
          ]
        }
      }
    }
    ```
