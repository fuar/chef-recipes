gitlab Cookbook
===============

Install omnibus gitlab with some kludges.

Requirements
------------

RHEL > 6 (probably 5).

chef


Attributes
----------
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['gitlab']['postgresql']['host']</tt></td>
    <td>String</td>
    <td>host for database</td>
    <td><tt>'127.0.0.1'</tt></td>
  </tr>
    <tr>
    <th>['gitlab']['postgresql']['port']</th>
    <th>String</th>
    <th>postgres port</th>
    <th>'5432'</th>
  </tr>
    <tr>
    <th>['gitlab']['postgresql']['username']</th>
    <th>String</th>
    <th>postgres username</th>
    <th>'postgres'</th>
  </tr>
    <tr>
    <th>['gitlab']['postgresql']['gitlab_database']</th>
    <th>String</th>
    <th>database for gitlab</th>
    <th>'gitlab'</th>
  </tr>
    <tr>
    <th>['gitlab']['postgresql']['gitlab_username']</th>
    <th>String</th>
    <th>username for gitlab database</th>
    <th>'gitlab'</th>
  </tr>
    <tr>
    <th>['gitlab']['postgresql']['gitlab_password']</th>
    <th>String</th>
    <th>password for gitlab database</th>
    <th>It's kinda stupid, set value of default password, dont't you think?</th>
  </tr>
    <tr>
    <th>['gitlab']['nginx']['url']</th>
    <th>String</th>
    <th>gitlab URL</th>
    <th>'https://gitlab.example.com'</th>
  </tr>
    <tr>
    <th>['gitlab']['nginx']['embedded']</th>
    <th>Boolean</th>
    <th>Enable or disable embedded nginx. Things may be work wrong, if enabling.</th>
    <th>'false'</th>
  </tr>
</table>

Usage
-----
#### gitlab::default

e.g.
Just include `gitlab` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[gitlab]"
  ]
}
```

Contributing
------------
TODO: (optional) If this is a public cookbook, detail the process for contributing. If this is a private cookbook, remove this section.

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: fuar
