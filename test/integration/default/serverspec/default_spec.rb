require "spec_helper"

describe "swpr_dev" do
  context "zsh" do
    describe package("zsh") do
      it { should be_installed }
    end

    describe file("/etc/zsh/zshenv") do
      it { should exist }
      it { should be_file }
    end

    describe command("grep \"^vagrant\" /etc/passwd | cut -d ':' -f 7") do
      its(:stdout) { should eq("/usr/bin/zsh\n") }
    end
  end
end
