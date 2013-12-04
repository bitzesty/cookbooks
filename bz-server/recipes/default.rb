#
# Cookbook Name:: bz-server
# Recipe:: default
#
# Copyright 2013, Bit Zesty
#
# All rights reserved - Do Not Redistribute

include_recipe "bz-server::packages"
include_recipe "bz-server::setup"
include_recipe "bz-server::locales"
include_recipe "bz-server::user"
include_recipe "bz-server::upstart"
include_recipe "bz-server::openssh"
include_recipe "imagemagick"
include_recipe "unattended_upgrades"
