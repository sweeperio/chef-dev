require "spec_helper"

describe "swpr_dev::nodejs" do
  %w(node npm coffee grunt).each do |exe|
    describe command("which #{exe}") do
      its(:exit_status) { should eq(0) }
      its(:stdout) { should eq("/usr/bin/#{exe}\n") }
    end
  end
end
