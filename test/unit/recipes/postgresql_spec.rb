#
# Cookbook Name:: swpr_dev
# Spec:: postgresql
#
# The MIT License (MIT)
#
# Copyright (c) 2016 sweeper.io
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

describe "swpr_dev::postgresql" do
  before do
    stub_command(%r{ls /.*/recovery.conf}).and_return(false)
  end

  cached(:chef_run) do
    runner = ChefSpec::SoloRunner.new do |node|
      node.set["swpr_dev"]["db"]["user"]     = "vagrant"
      node.set["swpr_dev"]["db"]["password"] = "developerPassword1"
    end

    runner.converge(described_recipe)
  end

  it "converges successfully" do
    expect { chef_run }.to_not raise_error
  end

  it "includes the postgresql server recipe" do
    expect(chef_run).to include_recipe("postgresql::server")
  end

  it "creates a vagrant user in postgres" do
    expect(chef_run).to create_db_user(chef_run.node.attr!("swpr_dev", "db", "user")).with(
      database: :postgresql,
      password: chef_run.node.attr!("swpr_dev", "db", "password")
    )
  end
end
