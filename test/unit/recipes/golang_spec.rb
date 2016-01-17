#
# Cookbook Name:: swpr_dev
# Spec:: golang
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

describe "swpr_dev::golang" do
  cached(:chef_run) do
    runner = ChefSpec::SoloRunner.new do |node|
      node.set["swpr_dev"]["golang"]["go_path"] = "/home/vagrant/go"
      node.set["swpr_dev"]["golang"]["version"] = "1.5.3"
    end

    runner.converge(described_recipe)
  end

  it "converges successfully" do
    expect { chef_run }.to_not raise_error
  end

  it "ensures the go_path directory exists" do
    path = chef_run.node.attr!("swpr_dev", "golang", "go_path")

    expect(chef_run).to create_directory(path).with(
      owner: "vagrant",
      group: "vagrant"
    )
  end

  it "creates the profile initializer" do
    expect(chef_run).to create_template("/etc/profile.d/go_profile.sh")
  end

  it "arks the specified version of go" do
    version = chef_run.node.attr!("swpr_dev", "golang", "version")

    expect(chef_run).to install_ark("go").with(
      url: "https://storage.googleapis.com/golang/go#{version}.linux-amd64.tar.gz",
      version: version
    )
  end
end
