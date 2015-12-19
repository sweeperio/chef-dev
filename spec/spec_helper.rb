require "chefspec"
require "chefspec/berkshelf"

Dir["./spec/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.platform = "ubuntu"
  config.version  = "14.04"
end

def stub_git_version
  stub_command("git --version >/dev/null").and_return("2.4.4")
  stub_command("dpkg -s memcached")
  stub_command("getent passwd memcache")
end
