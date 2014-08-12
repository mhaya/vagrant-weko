#subversion "weko" do
#  repository "http://forge.at.nii.ac.jp/svn/nc/repository/trunk"
#  revision "HEAD"
#  destination "/usr/local/repository"
#  action :checkout
#end
remote_file "#{Chef::Config[:file_cache_path]}/#{node['weko']['filename']}" do
  source node['weko']['remote_uri']
  action :create
end

script "install_weko" do
  interpreter "bash"
  user "root"
  code <<-EOL
  install -d #{node['weko']['install_dir']}
  tar zxvf #{Chef::Config[:file_cache_path]}/#{node['weko']['filename']} -C #{node['weko']['install_dir']}
  EOL
end

execute "chown" do
  command "chown -R www-data:www-data #{node['weko']['dir']}" 
end

link "#{node['netcommons']['dir']}/html/webapp/modules/repository" do
  to "#{node['weko']['dir']}"
  link_type :symbolic
end


