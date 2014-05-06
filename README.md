# Bit Zesty Chef cookbooks

**For recent changes please refer to [the changelog](https://github.com/bitzesty/cookbooks/blob/master/CHANGELOG.md)**.

## Recipes

### bz-server

* Installs general packages
* Configures upstart to support user jobs (loaded from `~/.init`).
* Sets up locales
* Sets up host aliases
* Sets up user account and SSH keys

### bz-database

* Responsible for installing and cofiguring various databases
* Supports database backup

### bz-webserver

* Responsible for installing and configuring various front end webservers like `nginx`.

### bz-rails

* Responsible for installing Ruby version manager, configuring Rails directories etc.

## Architecture notes

* Supports Chef Solo 10 and Chef Solo 11.
* Uses [Berkshelf](http://berkshelf.com) to manage cookbooks.
* Uses [knife-solo](https://github.com/matschaffer/knife-solo) to perform deployments to physical/virtual (non-Vagrant) servers.
* Uses [Vagrant](http://www.vagrantup.com) to develop installation for a project (Vagrant version `>= 1.2`).
* Uses local to deploy user [rbenv](https://github.com/sstephenson/rbenv) to manage Ruby versions
* Uses [upstart's](http://upstart.ubuntu.com/) [user jobs](http://bradleyayers.blogspot.com/2011/10/upstart-user-jobs-on-ubuntu-1110.html) + [foreman](https://github.com/ddollar/foreman) to manage application startup.
* Uses nginx as default web server

## How to extend these recipies

1. Make your changes on a branch
2. Add a changelog entry
3. Bump **ALL** cookbook versions in <cookbook_name>/metadata.rb files.
4. Merge into master
5. Tag a new release

NOTE: **all cookbooks should have the same version**. Consider this to be a stack version. If you find a Bit Zesty project using Chef you can then tell that its server were developed using `0.1.2` version of Bit Zesty server stack.

## Setup on a new project

##### Download and install [VirtualBox](https://www.virtualbox.org) if you do not have it.

##### Download and install [Vagrant](http://www.vagrantup.com) if you do not have it.

**IMPORTANT!!! Vagrant version to download from the site: 1.4.3**

##### Update project

* User upstart jobs are managed by chef but those have to be linked via
  capistrano on each deploy, so please add the following to the linked_dirs: ```config/deploy/templates```

  ```
  # example of full linked_dirs setting
  set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/backend/uploads config/deploy/templates}
  ```

##### Install Vagrant plugins

###### Install [vagrant-berkshelf](https://github.com/riotgames/vagrant-berkshelf).

````shell
vagrant plugin install vagrant-berkshelf
````
If you are using Vagrant 1.4.3 use this:

````shell
vagrant plugin install vagrant-berkshelf --plugin-version 1.3.7
````

###### Install [vagrant-omnibus](https://github.com/schisamo/vagrant-omnibus).

````
vagrant plugin install vagrant-omnibus
````

###### Install [vagrant-rackspace](https://github.com/mitchellh/vagrant-rackspace) if you going to deploy to rackspace

````
vagrant plugin install vagrant-rackspace
````

##### Create a Gemfile, we will be using local ruby gems to manage Chef project:

````
source "https://rubygems.org"

gem "knife-solo", '0.4.0' # try to use latest available
gem "knife-solo_data_bag"
gem "berkshelf"
````

###### Bundle install

````
bundle install
````

##### Initialize an empty knife solo project:

````
bundle exec knife solo init .
````

##### Create a Berksfile for your project and specify Bit Zesty cookbooks as well as other ones you are using:

````ruby
require 'open-uri'

site :opscode

STACK_VERSION = '0.1.28'

# FETCH_FROM_LOCAL is false by default, so fetching cookbooks from github
FETCH_FROM_LOCAL = false

# uncomment to fetch from local
# FETCH_FROM_LOCAL = true

def read_file(full_path)
  # from web or local
  begin
    if full_path.starts_with?("http")
      open(full_path).read
    else
      File.read(full_path)
    end
  rescue OpenURI::HTTPError, Errno::ENOENT
    nil
  end
end

def load_cookbook_dependencies(path)
  metadata = File.join(path, "metadata.rb")
  berks = File.join(path, "Berksfile.in")

  metadata_contents = read_file metadata
  berks_contents = read_file berks

  if metadata_contents && metadata_contents.include?(STACK_VERSION)
    instance_eval(berks_contents)
  else
    puts "WARNING: Could not open metadata or berks file on #{path}"
  end
end

def cookbooks_path
  if FETCH_FROM_LOCAL
    ENV['BZ_COOKBOOKS_PATH'] || File.join(File.dirname(__FILE__), "../../cookbooks")
  else
    "https://raw.githubusercontent.com/bitzesty/cookbooks/#{STACK_VERSION}"
  end
end

def fetch_cookbooks_from_local(cookbook)
  cookbook cookbook,
           "~> #{STACK_VERSION}",
           path: File.join(cookbooks_path, cookbook),
           rel: cookbook
end

def fetch_cookbooks_from_github(cookbook)
  cookbook cookbook,
           "~> #{STACK_VERSION}",
           git: "https://github.com/bitzesty/cookbooks.git",
           rel: cookbook,
           branch: "master"
end

%w[bz-server bz-webserver bz-database bz-rails].each do |cookbook|
  if FETCH_FROM_LOCAL
    fetch_cookbooks_from_local(cookbook)
  else
    fetch_cookbooks_from_github(cookbook)
  end

  # common
  load_cookbook_dependencies File.join(cookbooks_path, cookbook)
end

# example
# cookbook 'unattended-upgrades', '0.0.1', github: "phillip/chef-unattended-upgrades" # ubuntu upgrades

cookbook '<project_name>', path: './site-cookbooks/<project_name>'
````

**NOTE** The last should come project-specific cookbook from site-cookbooks.

**NOTE** Do not add the cookbooks that are already specified in bz cookbooks.

##### Add Vagrantfile to your project for developing the stack:

````ruby
require 'json'

Vagrant.configure("2") do |config|
  # uncomment if provisioning on Rackspace
  # Vagrant.require_plugin "vagrant-rackspace"

  # define server name
  config.vm.define "<project_name>" do |server|
  end

  SETTINGS = JSON.load(Pathname(__FILE__).dirname.join('nodes', 'vagrant.json').read)

  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.berkshelf.enabled = true
  config.omnibus.chef_version = "11.8.2"

  # add nginx repo public key to properly update packages
  config.vm.provision :shell, inline: "(sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7) || echo 0"
  # install make and ruby to not get compilation errors for chef gem installation
  config.vm.provision :shell, inline: "dpkg -s ruby1.9.1-dev || (sudo apt-get update && sudo aptitude -y install build-essential && sudo apt-get -y install ruby1.9.1-dev) || echo 0"
  config.vm.provision :shell, inline: "gem install chef --version 11.8.2 --no-rdoc --no-ri --conservative"

  # configure development via vagrant
  vagrant_development_path = "/home/#{SETTINGS["bz-server"]["user"]["name"]}/#{SETTINGS["bz-server"]["app"]["name"]}_dev"
  # forward ssh
  config.ssh.forward_agent = true
  # if you have issues with ssh not forwarded for private repositories uncomment the following, destroy and recreate VM
  # config.ssh.private_key_path = "~/.ssh/id_rsa"
  config.vm.network :private_network, ip: SETTINGS["bz-server"]["ip_address"]
  # grant max permissions as bz-server user is not created on initial machine setup
  config.vm.synced_folder (ENV["VM_SYNCED_FOLDER"] || ".."),
                          vagrant_development_path,
                          create: true,
                          mount_options: ['dmode=777', 'fmode=666']

  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.cpus = 2
  end

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["site-cookbooks"]
    chef.roles_path = "roles"
    chef.data_bags_path = "data_bags"

    # You may also specify custom JSON attributes:
    chef.json = SETTINGS

    # uncomment if defined a role in roles/
    # chef.add_role("frontend")
  end
end
````

##### Create 'nodes/vagrant.json' file. Check existing projects like

  * [TSS](https://github.com/bitzesty/ihealth/blob/master/chef/nodes/vagrant-backend.json)

  * [Casper](https://github.com/bitzesty/casper/blob/master/chef/nodes/vagrant.json)

  **NOTE** these keys may change, review the changelog and recipies for more info.

###### Set bz-database user password as "bzesty" for
vagrant environment such that we use the same password for development
on local and vagrant.

To change your password follow:

http://www.cyberciti.biz/faq/mysql-change-root-password/

http://stackoverflow.com/a/14588440/1630080

##### Update metadata with bz cookbooks dependencies

```ruby
# chef/site-cookbooks/tss/metadata.rb

# load attributes for bz cookbooks
depends "bz-server"
depends "bz-rails"
depends "bz-database"
depends "bz-webserver"
```

### To provision a Vagrant node

##### Execute the following

````
vagrant up
````

This will create a virtual machine at local and start provisioning process.

````
vagrant up --provider=rackspace
````

This will create a virtual machine on rackspace and start provisioning process.
Keep in mind that this step does a lot of work in the background
(talks to Rackspace Cloud Servers API, synchronizes Chef cookbooks, etc.)
so it might take a while to complete.

##### If you come on an error during provisioning you can fix it and start right were you left off with:

````
vagrant provision
````

##### To shutdown the vm

```
vagrant halt
```

##### To shutdown and remove the vagrant node, execute:

````
vagrant destroy
````

### To provision a real server

If server is not created check out the [Create servers via knife rackspace api](https://github.com/bitzesty/cookbooks/wiki/Create-servers-via-knife-rackspace-api)

##### Create `node.json` file similar to the `vagrant.json` just with the real/production values.
##### Copy your ssh key to remote server to avoid repeated password inputs while provisioning with Chef:

````
ssh-copy-id <username>@<hostname>
````

##### Bootstrap Chef inside this server:

````
bundle exec knife solo prepare <hostname> -x <username> --bootstrap-version=11.8.2
````

NOTE: vagrant Chef version and real Chef version should match.

NOTE: the <username> must have sudo permissions inside the server.

##### Check what will happen after your cook with `--why-run` flag.

````
bundle exec knife solo cook --ssh-keepalive 1200 <hostname> -x <username> --why-run
````

##### If changes to be made look reasonable, start actually cooking the server with:

````
bundle exec knife solo cook --ssh-keepalive 1200 <hostname> -x <username>
````

NOTE: ```--ssh-keepalive``` might give you an error then you are using older
knife version. As a workaround try adding the following to your ```chef/.chef/knife.rb```

```
require 'excon'
Excon.defaults[:read_timeout] = 1200
```

### Developing via vagrant

#### Setup

Add agent forwarding to ssh config:

```
# vim ~/.ssh/config
Host *
  ForwardAgent yes
```

Include the following into run list:

```json
"recipe[bz-rails::development_environment]"
```

Make sure synced folders are setup in Vagrantfile

Add the following gems to your gemfile, spring preloads your env:

```
group :development do
  gem "spring"
  gem "spring-commands-rspec"
end
```

#### Usage

After provisioning vagrant you can develop the application.

It is located at ```/home/<user>/<app>_dev```

##### Launch web server

```bash
ssh <user>@<app>_vagrant.app
cd <app>_dev
bundle # will take a while
rbenv rehash # update shims
bundle exec rake db:create db:migrate db:seed
spring rails s
```

##### Check the browser

```bash
<app>_vagrant.app:3000
```

Once you update code on your local machine, it gets automatically synced
to vagrant (yey).

To run specs, migrations and rake tasks ssh to the machine and launch them

### Upstart and Rails job control

The project should use foreman for its process management, refer to [TSS](https://github.com/bitzesty/ihealth/tree/master/config) for example Capistrano scripts and foreman templates.

### NOTES

* If you want to use different Chef version, here are the links to modify it for Vagrant and the real server:
  * [for Vagrant](http://stackoverflow.com/questions/11325479/how-to-control-the-version-of-chef-that-vagrant-uses-to-provision-vms)
  * [for knife solo](https://github.com/matschaffer/knife-solo/issues/184)
