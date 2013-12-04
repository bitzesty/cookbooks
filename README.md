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

1. Download and install [VirtualBox](https://www.virtualbox.org) if you do not have it.
2. Download and install [Vagrant](http://www.vagrantup.com) if you do not have it. NOTE `use version 1.2.x` and not the version from Rubygems.
3. Install Vagrant plugins:

    3.1 (necessary) [vagrant-berkshelf](https://github.com/riotgames/vagrant-berkshelf).

    ````shell
    vagrant plugin install vagrant-berkshelf
    ````

    3.2 (necessary) Install [vagrant-omnibus](https://github.com/schisamo/vagrant-omnibus).

    ````
    vagrant plugin install vagrant-omnibus
    ````

    3.3 (optional) Install [vagrant-rackspace](https://github.com/mitchellh/vagrant-rackspace) if you going to deploy to rackspace

    ````
    vagrant plugin install vagrant-rackspace
    ````

4. Create a Gemfile, we will be using local ruby gems to manage Chef project:

    ````
    source "https://rubygems.org"

    gem "knife-solo", '0.4.0' # try to use latest available
    gem "knife-solo_data_bag"
    gem "berkshelf"
    ````

5. Bundle install

    ````
    bundle install
    ````

6. Initialize an empty knife solo project:

    ````
    bundle exec knife solo init .
    ````

7. Create a Berksfile for your project and specify Bit Zesty cookbooks as well as other ones you are using:

    ````ruby
    site :opscode

    STACK_VERSION = '0.1.10' # USE THE LATEST AVAILABLE

    %w[bz-server bz-webserver bz-database bz-rails].each do |cookbook|
    cookbook cookbook, "~> #{STACK_VERSION}",
      git: "https://github.com/bitzesty/cookbooks.git",
      rel: cookbook,
      tag: STACK_VERSION
    end

    cookbook 'ufw'
    cookbook 'ohai'
    cookbook 'mongodb', '0.12.0', git: "https://github.com/edelight/chef-mongodb.git"
    cookbook 'rbenv', '0.7.3', git: 'https://github.com/fnichol/chef-rbenv.git'
    cookbook 'unattended-upgrades', '0.0.1', github: "phillip/chef-unattended-upgrades" # ubuntu upgrades
    cookbook '<project_name>', path: './site-cookbooks/<project_name>'
    ````

    **NOTE** The last should come project-specific cookbook from site-cookbooks.

8. Add Vagrantfile to your project for developing the stack:

    ````ruby
    require 'json'

    Vagrant.configure("2") do |config|
      # If you provisioning on Rackspace
      Vagrant.require_plugin "vagrant-rackspace"

      # define server name
      config.vm.define :<project_name> do |server|
        SETTINGS = JSON.load(Pathname(__FILE__).dirname.join('nodes', 'vagrant.json').read)

        config.vm.network :private_network, ip: "10.0.100.10"
        config.vm.box = "precise64"
        config.vm.box_url = "http://files.vagrantup.com/precise64.box"
        config.berkshelf.enabled = true
        config.omnibus.chef_version = "11.4.2"

        # Only if you are provisioning on Rackspace
        config.vm.provider :rackspace do |rs|
          rs.username = "API.user"
          rs.api_key  = "1b6182d059a454a8aaf4890c914e8ba"
          rs.flavor   = /512MB/
          rs.image    = "Ubuntu 12.04 LTS (Precise Pangolin)"
          rs.rackspace_region = :lon
        end

        config.vm.provision :chef_solo do |chef|
          chef.cookbooks_path = ["site-cookbooks"]
          chef.roles_path = "roles"
          chef.data_bags_path = "data_bags"

          # You may also specify custom JSON attributes:
          chef.json = SETTINGS
          chef.add_role("frontend") # if you defined a role in roles/
        end
      end
    end
    ````

9. Create 'nodes/vagrant.json' file. Check existing projects like
  * [TSS](https://github.com/bitzesty/ihealth/blob/master/chef/nodes/vagrant-backend.json)
  * [Casper](https://github.com/bitzesty/casper/blob/master/chef/nodes/vagrant.json)

  **NOTE** these keys may change, review the changelog and recipies for more info.

### To provision a Vagrant node

1. Execute:

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

2. If you come on an error during provisioning you can fix it and start right were you left off with:

    ````
    vagrant provision
    ````

3. To shutdown and remove the vagrant node, execute:

    ````
    vagrant destroy
    ````

### To provision a real server

1. Create `node.json` file similar to the `vagrant.json` just with the real/production values.
2. Copy your ssh key to remote server to avoid repeated password inputs while provisioning with Chef:

   ````
   ssh-copy-id <username>@<hostname>
   ````

2. Bootstrap Chef inside this server:

    ````
    bundle exec knife solo prepare <hostname> -x <username> --bootstrap-version=11.4.2
    ````

   NOTE: vagrant Chef version and real Chef version should match.

   NOTE: the <username> must have sudo permissions inside the server.

3. Check what will happen after your cook with `--why-run` flag.

   ````
   bundle exec knife solo cook <hostname> -x <username> --why-run
   ````

4. If changes to be made look reasonable, start actually cooking the server with:

   ````
   bundle exec knife solo cook <hostname> -x <username>
   ````

### Upstart and Rails job control

The project should use foreman for its process management, refer to [TSS](https://github.com/bitzesty/ihealth/tree/master/config) for example Capistrano scripts and foreman templates.

### NOTES

* If you want to use different Chef version, here are the links to modify it for Vagrant and the real server:
  * [for Vagrant](http://stackoverflow.com/questions/11325479/how-to-control-the-version-of-chef-that-vagrant-uses-to-provision-vms)
  * [for knife solo](https://github.com/matschaffer/knife-solo/issues/184)
