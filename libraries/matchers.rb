if defined?(ChefSpec)
  def create_db_user(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:swpr_dev_db_user, :create, resource_name)
  end
end
