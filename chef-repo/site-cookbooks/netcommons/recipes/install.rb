# -*- coding: utf-8 -*-
db_name = node['netcommons']['db_name']
user_name = node['netcommons']['db_user']
user_password = node['netcommons']['db_pass']

#
execute 'import table' do
  command "#{node['mysql']['mysql_cmd']} -u root #{db_name} < #{Chef::Config[:file_cache_path]}/nc2.sql"
  action :nothing
end

template "#{Chef::Config[:file_cache_path]}/nc2.sql" do
  source 'nc2.sql.erb'
  notifies :run, 'execute[import table]', :immediately
end


template "#{node['netcommons']['dir']}/html/webapp/config/install.inc.php" do
 source "install.inc.php.erb" 
 mode 0444
 owner node['site']['www_user']
 group node['site']['www_group']
end

#インストール後に生成されるファイルのコピー
script "install_htdoc" do
  interpreter "bash"
  user node['site']['www_user']
  group node['site']['www_group']
  code <<-EOL
  tar zxvf /vagrant/files/nc2.tar.gz -C #{node['netcommons']['home']}
  EOL
end
