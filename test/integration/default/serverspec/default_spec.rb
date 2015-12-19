require "spec_helper"

describe "dev::default" do
  APPS = %w(hub vim zsh)

  APPS.each do |app|
    describe command("which #{app}") do
      its(:stdout) { should_not eq("") }
    end
  end

  describe command("grep \"^vagrant\" /etc/passwd | cut -d ':' -f 7") do
    its(:stdout) { should eq("/usr/bin/zsh\n") }
  end

  describe command("vim --version") do
    its(:stdout) { should match(/\+ruby/) }
    its(:stdout) { should contain("Vi IMproved 7.4") }
  end

  context "zsh" do
    describe file("/etc/zsh/zshenv") do
      it { should be_file }
      it { should contain("export PATH=\"/usr/local/bin:/usr/bin:/bin") }
      it { should contain(". /etc/profile") }
    end
  end
end
