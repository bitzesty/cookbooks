# Changelog

## 0.1.2

* Added Chef 11 compatibility (tested with 11.4.2) (sauliusg)
* Added locale management recipe compatible with Chef 11 (sauliusg)

## 0.1.1

* Added support for user pubkey fetching from GitHub (sauliusg). E.g.:

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
