#
# Cookbook Name:: swpr_dev
# Spec:: remote_script
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

describe "swpr_dev::default" do
  let(:cache_path) { Chef::Config[:file_cache_path] }

  let(:chef_run) do
    runner = ChefSpec::SoloRunner.new(file_cache_path: cache_path, step_into: %w(swpr_dev_remote_script))
    runner.converge(described_recipe)
  end

  it "executes the script once downloaded" do
    path     = File.join(cache_path, "heroku_toolbelt.sh")
    resource = chef_run.remote_file(path)
    expect(resource).to notify("execute[install heroku_toolbelt via remote script]").to(:run).immediately
  end
end
