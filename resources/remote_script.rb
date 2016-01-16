default_action :install

property :name, String, name_property: true
property :url, String, required: true

action :install do
  file_path = ::File.join(Chef::Config[:file_cache_path], "#{name}.sh")

  execute "install #{name} via remote script" do
    action :nothing
    command file_path
  end

  remote_file file_path do
    action :create_if_missing
    source url
    mode 00755
    notifies :run, "execute[install #{new_resource.name} via remote script]", :immediately
  end
end
