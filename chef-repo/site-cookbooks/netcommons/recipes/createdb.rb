# -*- coding: utf-8 -*-
db_name = node['netcommons']['db_name']
user_name = node['netcommons']['db_user']
user_password = node['netcommons']['db_pass']

execute "createdb" do
  command "#{node['mysql']['mysql_cmd']} -u root < #{Chef::Config[:file_cache_path]}/createdb.sql"
  action :nothing
  not_if "#{node['mysql']['mysql_cmd']} -u root -D #{db_name}"
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
  command "#{node['mysql']['mysql_cmd']} -u root < #{Chef::Config[:file_cache_path]}/createuser.sql"
  action :nothing
  not_if "#{node['mysql']['mysql_cmd']} -u #{user_name} -p#{user_password} -D #{db_name}"
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

