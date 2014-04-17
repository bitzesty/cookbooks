# Changelog

## Master

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
