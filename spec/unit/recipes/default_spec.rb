#
# Cookbook Name:: dev
# Spec:: default
#
# Copyright (c) 2015 Sweeper Devs, All Rights Reserved.

require "spec_helper"

describe "dev::default" do
  INCLUDED_RECIPES = %w(
    apt
    build-essential
    dev::chruby
    dev::git
    dev::hub
    dev::nginx
    dev::vim
    dev::zsh
    memcached
    redisio
    redisio::enable
    tmux
  )

  cached(:chef_run) do
    runner = ChefSpec::ServerRunner.new do |node|
      node.set["dev"]["packages"] = %w(curl)
    end

    stub_git_version
    runner.converge(described_recipe)
  end

  it "installs packages" do
    expect(chef_run).to install_package("curl")
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
