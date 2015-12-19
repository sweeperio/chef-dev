#
# Cookbook Name:: dev
# Recipe:: default
#
# Copyright (c) 2015 Sweeper Devs, All Rights Reserved.

include_recipe "apt"
include_recipe "build-essential"
include_recipe "dev::chruby"
include_recipe "dev::git"
include_recipe "dev::hub"
include_recipe "dev::vim"
include_recipe "dev::zsh"

execute "set default shell" do
  command "chsh -s $(which #{node['dev']['vagrant_shell']}) vagrant"
end
