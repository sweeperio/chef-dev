#
# Cookbook Name:: dev
# Spec:: database
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require "spec_helper"

describe "dev::database" do
  POSTGRES_FILE = "/tmp/postgres-db-user.sql".freeze

  context "when no database server is in the run list" do
    cached(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it "doesn't create the postgres file" do
      expect(chef_run).to_not create_template(POSTGRES_FILE)
    end
  end

  context "when postgresql::server is in the run list" do
    cached(:chef_run) do
      runner = ChefSpec::ServerRunner.new do |node|
        expect(node).to receive(:recipe?).with("postgresql::server").and_return(true)
      end

      runner.converge(described_recipe)
    end

    it "creates the postgres user file" do
      expect(chef_run).to create_template(POSTGRES_FILE)
    end

    it "executes the script" do
      file = chef_run.template(POSTGRES_FILE)
      expect(file).to notify("execute[create postgres user]").to(:run).delayed
    end
  end
end
