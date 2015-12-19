#
# Cookbook Name:: dev
# Recipe:: default
#
# Copyright (c) 2015 Sweeper Devs, All Rights Reserved.

include_recipe "apt"
include_recipe "build-essential"
include_recipe "memcached"
include_recipe "nodejs"
include_recipe "phantomjs"
include_recipe "redisio"
include_recipe "redisio::enable"
include_recipe "tmux"

node["dev"]["packages"].each { |pkg| package pkg }

%w(chruby git hub nginx vim zsh).each do |recipe|
  include_recipe "dev::#{recipe}"
end

execute "set default shell" do
  command "chsh -s $(which #{node['dev']['vagrant_shell']}) vagrant"
end
