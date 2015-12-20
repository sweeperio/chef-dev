require "chefspec"
require "chefspec/berkshelf"

Dir["./spec/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.platform = "ubuntu"
  config.version  = "14.04"

  config.before(:all) do
    stub_command("git --version >/dev/null").and_return("2.6.4")
  end
end
