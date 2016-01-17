#
# Cookbook Name:: swpr_dev
# Recipe:: golang
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

go_path  = node.attr!("swpr_dev", "golang", "go_path")
version  = node.attr!("swpr_dev", "golang", "version")
packages = node.attr!("swpr_dev", "golang", "packages")

directory go_path do
  owner "vagrant"
  group "vagrant"
end

template "/etc/profile.d/go_profile.sh" do
  variables(go_path: go_path)
end

packages.each do |go_pkg|
  execute("go get #{go_pkg}") do
    environment("GOPATH" => go_path)
    action :nothing
  end
end

ark "go" do
  has_binaries %w(bin/go bin/gofmt bin/godoc)
  url "https://storage.googleapis.com/golang/go#{version}.linux-amd64.tar.gz"
  version version
  action :install

  packages.each do |go_pkg|
    notifies :run, "execute[go get #{go_pkg}]", :immediately
  end
end
