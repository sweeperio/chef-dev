require "spec_helper"

describe "swpr_dev" do
  context "tmux" do
    describe command("which tmux") do
      its(:exit_status) { should eq(0) }
    end

    describe file("/etc/tmux.conf") do
      it { should exist }
      it { should be_file }
      it { should be_mode("644") }
    end
  end

  context "vim" do
    describe command("which vim") do
      its(:exit_status) { should eq(0) }
    end

    describe command("vim --version") do
      its(:stdout) { should contain("Vi IMproved 7.4") }
      its(:stdout) { should match(/\+ruby/) }
    end
  end

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
