# -*- encoding: utf-8 -*-

#subversion "weko" do
#  repository "http://forge.at.nii.ac.jp/svn/nc/repository/trunk"
#  revision "HEAD"
#  destination "/usr/local/repository"
#  action :checkout
#end
remote_file "#{Chef::Config[:file_cache_path]}/#{node['weko']['filename']}" do
  source node['weko']['remote_uri']
  checksum node[:weko][:checksum]
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
  command "chown -R #{node['site']['www_user']}: #{node['weko']['dir']}" 
end

#シンボリックリンクの作成
link "#{node['netcommons']['dir']}/html/webapp/modules/repository" do
  to "#{node['weko']['dir']}"
  link_type :symbolic
  # すでにシンボリックリングが存在する場合は作成しない。
  not_if { File.exists?("#{node['netcommons']['dir']}/html/webapp/modules/repository") }
end


