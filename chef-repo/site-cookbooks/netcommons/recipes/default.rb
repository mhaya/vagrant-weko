remote_file "#{Chef::Config[:file_cache_path]}/#{node['netcommons']['filename']}" do
  source node['netcommons']['remote_uri']
  action :create
end

script "install_netcommons" do
  interpreter "bash"
  user "root"
  code <<-EOL
  install -d #{node['netcommons']['install_dir']}
  tar zxvf #{Chef::Config[:file_cache_path]}/#{node['netcommons']['filename']} -C #{node['netcommons']['install_dir']}
  EOL
end

execute "chown" do
  command "chown -R www-data:www-data #{node['netcommons']['dir']}" 
end

link "#{node['nginx']['root_dir']}/nc2" do
  to "#{node['netcommons']['home']}"
  link_type :symbolic
end
