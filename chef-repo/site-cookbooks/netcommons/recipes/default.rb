remote_file "#{Chef::Config[:file_cache_path]}/#{node['netcommons']['filename']}" do
  source node['netcommons']['remote_uri']
  checksum node[:nc2][:checksum]
  action :create
end

script "install_netcommons" do
  interpreter "bash"
  user "root"
  code <<-EOL
  install -d #{node['site']['nc2_install']}
  tar zxvf #{Chef::Config[:file_cache_path]}/#{node['netcommons']['filename']} -C #{node['site']['nc2_install']}
  EOL
end

execute "chown" do
  command "chown -R #{node['site']['www_user']}: #{node['netcommons']['dir']}" 
end

link "#{node['site']['www_root']}/nc2" do
  to "#{node['netcommons']['home']}"
  link_type :symbolic
end
