# CHEF TUTORIAL

## What is it?

http://docs.opscode.com/

A tool to provision machines with environment that your projects can be
run from.

## Tools

### Vagrant

To develop recipies it is convenient to setup vagrant, it launches virtual
box VMs and executes your chef recipies on them.

### Knife solo

There are two ways to manage servers - via chef server or via knife
solo. We use knife, it prepares server for chef recipes run and launches
the run itself.

### Berks

It is like a bundler but for chef. Ensures that you work with the
correct versions of cookbooks (they are like gems)

### How does it work?

#### For each project

There is one project specific cookbook which contains the deviations
from standard configuration (e.g. project is using two servers instead
of one)

##### For each server (node)

Each server (so called *node*) has it's own json configuration which
stores the attribute list that defines server ip, user names, passwords,
etc.

_It is very important to keep unique passwords for each node_

##### How many servers do we need?

If application is using one server setup, then one server per
environment:

* staging
* demo
* production
* development

Node configuration name usually is `<env>_<application>.json`

Development environment is unique as it is used both for the chef
scripts development and for the application development once that is
setup. To make things easier development environment server is managed
via vagrant instead of knife, it's node name is
`vagrant_<application>.json`.

### Chef resources

#### Cookbooks

Cookbooks are like gems, they know how to do something - e.g. setup
mysql server. The cookbooks that we wrote and use in every project are:

* *bz-server* - configures server: packages, ssh, users, directories, firewall, etc.
* *bz-database* - configures database and backups
* *bz-webserver* - configures nginx, passenger, varden
* *bz-rails* - installs and configures rbenv, dotenv, database
  configuration file, sets up development environment

#### Node configuration

Tells chef what are the attribute values - ips, passwords, user names,
webserver used, ruby version, etc. If you need to change something it
would be great if you could do that just specifying attributes, if not -
you'll have to write a recipe.

##### Run list

How does chef know that development environment should be configured for
vagrant machine only and the backups for production only?

Run list tells which recipes and in which order to execute. Order is
important, you cannot configure firewall while it is not installed yet.

#### Recipes

They tell exactly what to do: copy rsa.pub key, install packages, create
directories, etc. You can provision server executing bash commands in recipies
but chef has a lot of nice wrappers around those, we'll get back to them
later.

#### Attributes

How do we know what database should the recipe setup?

Via attributes, they define the server configuration - ips, environment
configuration, user names, nginx configuration details.

There are many things which stay constant among most of the projects
(e.g. we usually run two passenger instances per web server) so those
can be set via default values.

Default values can be overriden by node configuration.

#### Files

How do copy a certificate via chef?

Use file resource, place the file to `cookbook/files/default/<file_name>` and
tell chef to copy it.

#### Templates

For nginx configuration we could write one for each project and each
environment and copy that via file. But the configuration change is
small per environment and per project so we use a template
(e.g. nginx-vhost.erb) to generate the configuration file.

### Chef supplied wrappers - so called resources

As previously mentioned chef has a lot of nice wrappers for common
tasks.

All about them: http://docs.opscode.com/chef/resources.html

The list of available resources: http://docs.opscode.com/chef/resources.html#resources

Take time to read this, it will save you a lot of effort and help to
learn the chef way.

#### Cookbook file example

```
cookbook_file cert_file do
  backup 5
  owner node['bz-server']['user']['name']
  group node['bz-server']['user']['name']
  mode 0644
  cookbook node['bz-webserver']['nginx']['ssl_certs_cookbook']
end
```

## Done?

Seems like that's all you need to know about the chef basics.

If you want to find out how BitZesty uses chef please read:

https://github.com/bitzesty/cookbooks

https://github.com/bitzesty/cookbooks/tree/master/bz-database

https://github.com/bitzesty/cookbooks/tree/master/bz-webserver

https://github.com/bitzesty/cookbooks/tree/master/bz-rails

https://github.com/bitzesty/cookbooks/tree/master/bz-server

Once you get into issue and do not understand why something fails, read
the cookbooks - they are easy to understand and knowing the internal
logic you will find ways how to force it into the way you need.

## Cookbook development

### For cookbooks repository

#### Clone cookbooks project

```
git clone git@github.com:bitzesty/cookbooks.git
cd cookbooks
```

#### Add cookbooks path to env variables, can update .bashrc

```
export BZ_COOKBOOKS_PATH=/<path_to_cookbooks>/cookbooks
```

### In your project

Go to chef directory

```
cd <project>/chef
bundle
```

#### Update Berksfile

Uncomment line to fetch cookbooks from local

```
vim Berksfile

# uncomment
# FETCH_FROM_LOCAL = true
```

#### Update cookbooks

```
berks update

# if that fails, then:
rm Berksfile.lock && berks
```

### Edit cookbooks and test

Testing on vagrant

```
# in project /chef directory
vagrant up
vagrant provision

# edit cookbooks
vagrant provision
```

#### Try out commands

Before writing chef recipes you should try out command on local to know
exactly what you need to execute and ensure that it works

```
# sign in as vagrant user
vagrant ssh

# get root access
sudo su

# test out commands
```

Sadly the commands do not directly map to chef recipe resources but you
still should not write recipe when you do not know what is the outcome
of it.

### Prepare a release

Each new cookbook version must have it's own release.

#### Update cookbooks version

I use regexxer to update multiple files, need to update version number
for:

https://github.com/bitzesty/cookbooks/blob/master/bz-database/metadata.rb#L7

https://github.com/bitzesty/cookbooks/blob/master/bz-rails/metadata.rb#L7

https://github.com/bitzesty/cookbooks/blob/master/bz-server/metadata.rb#L7

https://github.com/bitzesty/cookbooks/blob/master/bz-webserver/metadata.rb#L7

#### Document change in CHANGELOG.md

https://github.com/bitzesty/cookbooks/blob/master/CHANGELOG.md

#### Update Berksfile example

The example should always point to newest version

https://github.com/bitzesty/cookbooks/blob/master/README.md#create-a-berksfile-for-your-project-and-specify-bit-zesty-cookbooks-as-well-as-other-ones-you-are-using

#### Make a pull request

Cookbooks are owned by BitZesty and we should all know what they do, so
it is important to review the pull requests.

Once the pull request is merged to master there is one more thing to do
before the cookbook can be used

#### Draft a new release

Go to https://github.com/bitzesty/cookbooks/releases

Click "Draft a new release"

### Use a new release in your project

Update Berksfile with new version

```
# change STACK_VERSION = '0.x.xx' to newest version

# comment out fetching from local as now we use a release from github
# FETCH_FROM_LOCAL = true
```

Update project with new cookbooks

```
berks update
```

Yey, now you can cook :)

### Release has a tiny error, how do I update it?

Update the code, push to master.

Delete a realease:

```
git push origin :refs/tags/0.x.xx
```

Draft a new release
