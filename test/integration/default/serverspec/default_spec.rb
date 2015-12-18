require "spec_helper"

describe "dev::default" do
  context "zsh" do
    describe command("which zsh") do
      its(:stdout) { should eq("/usr/bin/zsh\n") }
    end

    describe file("/etc/zsh/zshenv") do
      it { should be_file }
      it { should contain("export PATH=\"/usr/local/bin:/usr/bin:/bin") }
      it { should contain(". /etc/profile") }
    end
  end
end
