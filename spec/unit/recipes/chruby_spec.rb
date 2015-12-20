#
# Cookbook Name:: dev
# Spec:: chruby
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require "spec_helper"

describe "dev::chruby" do
  INSTALLED_GEMS = %w(bundler ejson).freeze

  cached(:chef_run) do
    runner = ChefSpec::ServerRunner.new do |node|
      node.set["dev"]["gems"] = INSTALLED_GEMS
    end

    runner.converge(described_recipe)
  end

  it "includes chruby::system" do
    expect(chef_run).to include_recipe("chruby::system")
  end

  it "installs gems for all installed rubies" do
    INSTALLED_GEMS.each do |gem|
      expect(chef_run).to run_execute("install #{gem} for ruby 2.2.3")
    end
  end

  it "doesn't attempt to install bundler for uninstalled rubies" do
    expect(chef_run).to_not run_execute("install bundler for ruby 1.9.3-p392")
  end
end
