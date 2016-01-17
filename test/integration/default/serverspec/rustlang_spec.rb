require "spec_helper"

describe "swpr_dev::rustlang" do
  %w(cargo rustc rustdoc).each do |exe|
    describe command("which #{exe}") do
      its(:exit_status) { should eq(0) }
    end
  end
end
