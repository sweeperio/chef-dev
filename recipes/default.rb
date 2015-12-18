#
# Cookbook Name:: dev
# Recipe:: default
#
# Copyright (c) 2015 Sweeper Devs, All Rights Reserved.

include_recipe "dev::zsh"

execute "set default shell" do
  command "chsh -s $(which #{node["dev"]["vagrant_shell"]}) vagrant"
end
