#
# Cookbook Name:: swpr_dev
# Spec:: _nginx
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

describe "swpr_dev::_nginx" do
  cached(:chef_run) do
    runner = ChefSpec::SoloRunner.new
    runner.converge(described_recipe)
  end

  it "converges successfully" do
    expect { chef_run }.to_not raise_error
  end

  it "includes the open_resty recipe" do
    expect(chef_run).to include_recipe("open_resty")
  end

  it "creates and enables the dev nginx conf for rails apps" do
    expect(chef_run).to create_nginx_site("dev-rails-nginx.conf.erb")
    expect(chef_run).to enable_nginx_site("dev-rails-nginx.conf.erb")
  end

  it "links luajit to usr/local/bin" do
    expect(chef_run).to create_link("/usr/local/bin/luajit").with(
      to: "/usr/local/openresty/luajit/bin/luajit-2.1.0-beta1"
    )
  end
end
