#
# Cookbook Name:: dev
# Recipe:: hub
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

HUB_REPO    = "https://github.com/github/hub".freeze
HUB_VERSION = "2.2.2".freeze
HUB_SOURCE  = "#{HUB_REPO}/releases/download/v#{HUB_VERSION}/hub-linux-amd64-#{HUB_VERSION}.tgz".freeze

ark "hub" do
  url HUB_SOURCE
  action :cherry_pick
  version HUB_VERSION
  path "/usr/local"
  creates "hub-linux-amd64-#{HUB_VERSION}/bin/hub"
end
