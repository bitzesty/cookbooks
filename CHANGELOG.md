# Changelog

## Master

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
