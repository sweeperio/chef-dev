require "spec_helper"

describe "swpr_dev" do
  context "fasd" do
    describe command("which fasd") do
      its(:exit_status) { should eq(0) }
    end
  end

  context "heroku toolbelt" do
    describe command("which heroku") do
      its(:exit_status) { should eq(0) }
      its(:stdout) { should eq("/usr/bin/heroku\n") }
    end
  end

  context "hub" do
    describe command("which hub") do
      its(:exit_status) { should eq(0) }
    end
  end

  context "memcached" do
    describe service("memcached") do
      it { should be_enabled }
      it { should be_running }
    end

    describe port("11211") do
      it { should be_listening }
    end
  end

  context "open resty" do
    describe file("/etc/nginx/sites-available/dev-rails-nginx.conf") do
      it { should exist }
      it { should be_file }
    end

    describe file("/etc/nginx/sites-enabled/dev-rails-nginx.conf") do
      it { should exist }
      it { should be_file }
      it { should be_symlink }
      it { should be_linked_to("/etc/nginx/sites-available/dev-rails-nginx.conf") }
    end

    describe command("which luajit") do
      its(:exit_status) { should eq(0) }
      its(:stdout) { should eq("/usr/local/bin/luajit\n") }
    end

    describe command("luajit -v") do
      its(:stdout) { should contain("LuaJIT 2.1.0") }
    end
  end

  context "redis" do
    describe service("redis6379") do
      it { should be_enabled }
      it { should be_running }
    end

    describe port(6379) do
      it { should be_listening }
    end

    describe command("which redis-cli") do
      its(:exit_status) { should eq(0) }
    end

    describe command("which redis-server") do
      its(:exit_status) { should eq(0) }
    end
  end

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
