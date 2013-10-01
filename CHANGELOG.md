# Changelog

## Master

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
