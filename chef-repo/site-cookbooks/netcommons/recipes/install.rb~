# -*- coding: utf-8 -*-
db_name = node['netcommons']['db_name']
user_name = node['netcommons']['db_user']
user_password = node['netcommons']['db_pass']

execute "createdb" do
  command "/usr/bin/mysql -u root < #{Chef::Config[:file_cache_path]}/createdb.sql"
  action :nothing
  not_if "/usr/bin/mysql -u root -D #{db_name}"
end

template "#{Chef::Config[:file_cache_path]}/createdb.sql" do
  source 'createdb.sql.erb'
  variables({
    :db_name => db_name,
    })
  notifies :run, 'execute[createdb]', :immediately
end
 
# create database user
execute 'createuser' do
  command "/usr/bin/mysql -u root < #{Chef::Config[:file_cache_path]}/createuser.sql"
  action :nothing
  not_if "/usr/bin/mysql -u #{user_name} -p#{user_password} -D #{db_name}"
end
 
template "#{Chef::Config[:file_cache_path]}/createuser.sql" do
  source 'createuser.sql.erb'
  variables({
      :db_name => db_name,
      :username => user_name,
      :password => user_password,
    })
  notifies :run, 'execute[createuser]', :immediately
end

execute 'createtable' do
  command "/usr/bin/mysql -u root #{db_name} < #{Chef::Config[:file_cache_path]}/nc2.sql"
  action :nothing
end

template "#{Chef::Config[:file_cache_path]}/nc2.sql" do
  source 'nc2.sql.erb'
  notifies :run, 'execute[createtable]', :immediately
end


template "#{node['netcommons']['dir']}/html/webapp/config/install.inc.php" do
 source "install.inc.php.erb" 
 mode 0444
 owner 'www-data'
 group 'www-data'
end

#インストール後に生成されるファイルのコピー
script "install_htdoc" do
  interpreter "bash"
  user "www-data"
  code <<-EOL
  tar zxvf /vagrant/files/nc2.tar.gz -C #{node['netcommons']['home']}
  EOL
end
