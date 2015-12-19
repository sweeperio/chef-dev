#
# Cookbook Name:: dev
# Recipe:: database
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

POSTGRES_FILE = "/tmp/postgres-db-user.sql".freeze
DATABASE_USER = node["dev"]["database_user"].freeze
DATABASE_PASS = node["dev"]["database_password"].freeze

execute "create postgres user" do
  user "postgres"
  command "psql -f #{POSTGRES_FILE}"
  action :nothing
end

template POSTGRES_FILE do
  source "postgresql-vagrant-user.sql.erb"
  variables user: DATABASE_USER, password: DATABASE_PASS
  notifies :run, "execute[create postgres user]", :delayed
  only_if { node.recipe?("postgresql::server") }
end
