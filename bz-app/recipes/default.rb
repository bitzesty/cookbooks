#
# Cookbook Name:: bz-app
# Recipe:: default
#
# Copyright 2013, Bit Zesty
#
# All rights reserved - Do Not Redistribute

include_recipe "bz-app::setup"
include_recipe "bz-app::packages"
include_recipe "bz-app::user"
include_recipe "bz-app::rbenv"
