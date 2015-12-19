#
# Cookbook Name:: dev
# Recipe:: chruby
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe "chruby::system"

node["chruby"]["rubies"].each do |ruby, installed|
  next unless installed

  node["dev"]["gems"].each do |gem|
    execute "install #{gem} for ruby #{ruby}" do
      command "/opt/rubies/#{ruby}/bin/gem install #{gem}"
      not_if { ::File.exist?("/opt/rubies/#{ruby}/bin/#{gem}") }
    end
  end
end
