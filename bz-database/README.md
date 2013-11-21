bz-database Cookbook
===============
This cookbook wraps database receipes to easily setup database and user
for rails database.

Usage
-----
#### bz-database

Currently supported databases: mysql, mongo, postgres

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
