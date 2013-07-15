bz-rails Cookbook
===============
TODO: Enter the cookbook description here.

e.g.
This cookbook makes your favorite breakfast sandwhich.

Requirements
------------
TODO: List your cookbook requirements. Be sure to include any requirements this cookbook has on platforms, libraries, other cookbooks, packages, operating systems, etc.

e.g.
#### packages
- `toaster` - bz-rails needs toaster to brown your bagel.

Attributes
----------
TODO: List you cookbook attributes here.

e.g.
#### bz-rails::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['bz-rails']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

Usage
-----
#### bz-rails::default
TODO: Write usage instructions for each cookbook.

e.g.
Just include `bz-rails` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[bz-rails]"
  ]
}
```

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
