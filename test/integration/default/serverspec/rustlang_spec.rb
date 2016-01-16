require "spec_helper"

describe "swpr_dev::rustlang" do
  describe command("which rustc") do
    its(:exit_status) { should eq(0) }
  end

  describe command("which rustdoc") do
    its(:exit_status) { should eq(0) }
  end
end
