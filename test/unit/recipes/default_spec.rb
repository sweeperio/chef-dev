#
# Cookbook Name:: swpr_dev
# Spec:: default
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
  PRIVATE_RECIPES = %w(_hub _nginx _shell _tmux _vim).freeze

  cached(:chef_run) do
    runner = ChefSpec::SoloRunner.new
    runner.converge(described_recipe)
  end

  it "converges successfully" do
    expect { chef_run }.to_not raise_error
  end

  PRIVATE_RECIPES.each do |recipe|
    it "includes the #{recipe} recipe" do
      expect(chef_run).to include_recipe("swpr_dev::#{recipe}")
    end
  end

  it "includes the fasd recipe" do
    expect(chef_run).to include_recipe("fasd")
  end

  it "includes the memcached recipe" do
    expect(chef_run).to include_recipe("memcached")
  end

  it "includes the redisio recipes" do
    expect(chef_run).to include_recipe("redisio")
    expect(chef_run).to include_recipe("redisio::enable")
  end

  it "installs the Heroku toolbelt" do
    expect(chef_run).to install_remote_script("heroku_toolbelt").with(
      url: "https://toolbelt.heroku.com/install-ubuntu.sh"
    )
  end
end
