bz-server Cookbook
===============
Cookbook for provisioning the server to host the app

Requirements
------------
Designed for debian and rhel platform families

Usage
-----
#### bz-server::default

Include `bz-server` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[bz-server]"
  ]
}
```
#### Elastic Search
To add elastic search please include:

##### into run list

```json
"recipe[bz-server::elasticsearch]"
```

##### into node configuration
```json
"java": {
  "install_flavor": "openjdk",
  "jdk_version": "7"
},

"elasticsearch": {
  "cluster_name" : "<cluster_name>",
  "bootstrap.mlockall" : false
}
```

##### into berksfile

```
cookbook 'java', '<version>' # http://community.opscode.com/cookbooks/java
cookbook 'elasticsearch', '<version>' # http://community.opscode.com/cookbooks/elasticsearch
cookbook 'monit', '<version>' # http://community.opscode.com/cookbooks/monit
```

Attributes
----------
TODO: List you cookbook attributes here.

e.g.
#### bz-server::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['bz-server']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

Usage
-----
#### bz-server::default
TODO: Write usage instructions for each cookbook.

e.g.
Just include `bz-server` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[bz-server]"
  ]
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
