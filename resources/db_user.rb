default_action :create

property :username, String, name_property: true
property :password, String, required: true
property :database, [:postgresql], default: :postgresql

load_current_value do
  exists = %(psql -c "SELECT rolname FROM pg_roles WHERE rolname = '#{username}'" | grep '#{username}')

  cmd = Mixlib::ShellOut.new(exists, user: "postgres")
  cmd.run_command
  current_value_does_not_exist! unless cmd.exitstatus.zero?
end

action :create do
  return unless current_resource.nil?

  execute "create postgres user #{username}" do
    user "postgres"
    command %(psql -c "CREATE ROLE #{username} WITH CREATEDB LOGIN PASSWORD '#{password}'")
    sensitive true
  end
end
