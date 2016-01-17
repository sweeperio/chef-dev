require "spec_helper"

describe "swpr_dev::golang" do
  describe file("/etc/profile.d/go_profile.sh") do
    it { should exist }
    it { should be_file }
    its(:content) { should contain(%(export GOPATH="/home/vagrant/go")) }
  end

  %w(go godoc gofmt).each do |exe|
    describe command("which #{exe}") do
      its(:exit_status) { should eq(0) }
      its(:stdout) { should eq("/usr/local/bin/#{exe}\n") }
    end
  end

  %w(gb godep).each do |exe|
    describe command("which #{exe}") do
      let(:shell) { "/bin/bash" }
      its(:exit_status) { should eq(0) }
    end
  end
end
