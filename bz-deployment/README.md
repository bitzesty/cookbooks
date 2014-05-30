bz-deployment Cookbook
===============

This cookbook allows deployment, rollback and maintenance page setting
for application.

## Usage

### Setup an application configuration

This is required for application that are not setup yet

Check that the project is not setup yet on

https://github.com/bitzesty/cookbooks/tree/master/bz-deployment/scripts/projects

If that is not there yet, copy configuration from another project and
update with the project attributes.

Please note that each environment has it's own configuration file

#### Generate the node configuration

The generated configuration will combine your project setup with
required run list for each task

### Run a desired task for the project



#### deploy

#### rollback

#### start_maintenance

#### stop_maintenance

