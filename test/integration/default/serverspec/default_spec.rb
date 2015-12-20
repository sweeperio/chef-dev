require "spec_helper"

describe "dev::default" do
  APPS = %w(
    coffee curl fasd grunt hub memcached node npm phantomjs redis-server redis-cli
    sudo tmux vim zsh
  ).freeze

  SERVICES = %w(memcached nginx redis6379).freeze

  CHRUBY_FILES = %w(
    /etc/profile.d/chruby.sh
    /usr/local/share/chruby/chruby.sh
    /usr/local/share/chruby/auto.sh
  ).freeze

  APPS.each do |app|
    describe command("which #{app}") do
      its(:stdout) { should_not eq("") }
    end
  end

  SERVICES.each do |service|
    describe service(service) do
      it { should be_enabled }
      it { should be_running }
    end
  end

  describe command("grep \"^vagrant\" /etc/passwd | cut -d ':' -f 7") do
    its(:stdout) { should eq("/usr/bin/zsh\n") }
  end

  describe command("vim --version") do
    its(:stdout) { should match(/\+ruby/) }
    its(:stdout) { should contain("Vi IMproved 7.4") }
  end

  context "chruby" do
    CHRUBY_FILES.each do |path|
      describe file(path) do
        it { should be_file }
      end
    end

    %w(bundler ejson).each do |gem|
      describe command("gem list") do
        its(:stdout) { should contain(gem) }
      end
    end
  end

  context "open resty/nginx" do
    describe file("/etc/nginx/sites-available/dev-rails-nginx.conf") do
      it { should exist }
    end

    describe file("/etc/nginx/sites-enabled/dev-rails-nginx.conf") do
      it { should exist }
    end

    describe command("luajit -v") do
      its(:stdout) { should match(/^LuaJIT 2\.1\.0/) }
    end
  end

  context "sudo" do
    describe group("sudoers") do
      it { should exist }
    end

    describe user("vagrant") do
      it { should exist }
      it { should belong_to_group("sudoers") }
    end
  end

  context "zsh" do
    describe file("/etc/zsh/zshenv") do
      it { should be_file }
      it { should contain("export PATH=\"/usr/local/bin:/usr/bin:/bin") }
      it { should contain(". /etc/profile") }
    end
  end
end
