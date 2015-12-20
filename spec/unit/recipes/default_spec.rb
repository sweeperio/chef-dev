#
# Cookbook Name:: dev
# Spec:: default
#
# Copyright (c) 2015 Sweeper Devs, All Rights Reserved.

require "spec_helper"

describe "dev::default" do
  INCLUDED_RECIPES = %w(
    dev::chruby
    dev::database
    dev::hub
    dev::nginx
    dev::vim
    dev::zsh
    fasd
    memcached
    nodejs
    phantomjs
    redisio
    redisio::enable
    tmux
  )

  cached(:chef_run) do
    runner = ChefSpec::ServerRunner.new do |node|
      node.set["nodejs"]["npm_packages"] = [{ name: "coffee-script" }]
    end

    stub_command("dpkg -s memcached")
    stub_command("getent passwd memcache")

    runner.converge(described_recipe)
  end

  it "creates the sudoers group and adds vagrant to it" do
    expect(chef_run).to create_group("sudoers").with(members: %w(vagrant))
  end

  it "installs npm packages" do
    expect(chef_run).to install_nodejs_npm("coffee-script")
  end

  it "includes recipes" do
    INCLUDED_RECIPES.each do |recipe|
      expect(chef_run).to include_recipe(recipe)
    end
  end

  it "sets the default shell for the vagrant user" do
    expect(chef_run).to run_execute("set default shell")
  end
end
