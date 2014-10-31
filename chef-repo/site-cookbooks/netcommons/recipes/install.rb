# -*- coding: utf-8 -*-
db_name = node['netcommons']['db_name']
user_name = node['netcommons']['db_user']
user_password = node['netcommons']['db_pass']

#
execute 'import table' do
  command "/usr/bin/mysql -u root #{db_name} < #{Chef::Config[:file_cache_path]}/nc2.sql"
  action :nothing
end

template "#{Chef::Config[:file_cache_path]}/nc2.sql" do
  source 'nc2.sql.erb'
  notifies :run, 'execute[import table]', :immediately
end


template "#{node['netcommons']['dir']}/html/webapp/config/install.inc.php" do
 source "install.inc.php.erb" 
 mode 0444
 owner node['netcommons']['username']
 group node['netcommons']['groupname']
end

#インストール後に生成されるファイルのコピー
script "install_htdoc" do
  interpreter "bash"
  user node['netcommons']['username']
  code <<-EOL
  tar zxvf /vagrant/files/nc2.tar.gz -C #{node['netcommons']['home']}
  EOL
end
