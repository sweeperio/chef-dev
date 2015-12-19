#
# Cookbook Name:: dev
# Spec:: hub
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require "spec_helper"

describe "dev::hub" do
  cached(:chef_run) do
    runner = ChefSpec::ServerRunner.new
    runner.converge(described_recipe)
  end

  it "arks hub from github" do
    expect(chef_run).to cherry_pick_ark("hub").with(
      path: "/usr/local",
      creates: "hub-linux-amd64-2.2.2/bin/hub"
    )
  end
end
