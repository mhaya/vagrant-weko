# -*- coding: utf-8 -*-
#
# Cookbook Name:: oaicatmuseum
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

remote_file "#{node[:tomcat][:webapps_dir]}/#{node[:oaicatmuseum][:file]}" do
  source node[:oaicatmuseum][:file_url]
  checksum node[:oaicatmuseum][:file_checksum]
  action :create
end

# http://www.oclc.org/content/dam/research/activities/oaicatmuseum/oaicatdb.sql
# を使う場合は以下のコメントアウトを外す。
# こっから。
#remote_file "#{Chef::Config[:file_cache_path]}/#{node[:oaicatmuseum][:file2]}" do
#  source node[:oaicatmuseum][:file2_url]
#  checksum node[:oaicatmuseum][:file2_checksum]
#  action :create
#end
# ここまで。

# 上記のコメントアウトを外した場合は以下をコメントアウトする。
# こっから
template "#{Chef::Config[:file_cache_path]}/#{node[:oaicatmuseum][:file2]}" do
  source "#{node[:oaicatmuseum][:file2]}.erb"
  variables({
    })
  action :create
end
# ここまで

execute "create_oaicatmuseum_db" do
  command "#{node['mysql']['mysqladmin_cmd']} -u root create oaicatdb"  
  not_if "#{node['mysql']['mysql_cmd']} -u root -D oaicatdb"
#  notifies :run, 'execute[create_oaicatmuseum_table]', :immediately
end

execute "create_oaicatmuseum_table" do
  command "#{node['mysql']['mysql_cmd']} -u root oaicatdb < #{Chef::Config[:file_cache_path]}/#{node[:oaicatmuseum][:file2]}"
#  action :nothing
end

template "#{Chef::Config[:file_cache_path]}/create_oaicatmuseum_user.sql" do
  source 'create_oaicatmuseum_user.sql.erb'
  variables({
    })
#  action :create
  notifies :run, 'execute[create_oaicatmuseum_dbuser]', :immediately
end

execute "create_oaicatmuseum_dbuser" do
  command "#{node['mysql']['mysql_cmd']} -u root < #{Chef::Config[:file_cache_path]}/create_oaicatmuseum_user.sql;sleep 120"
#  action :nothing
end

script "copy_mysql-connector-java" do
   interpreter "bash"
   user "root"
#   cwd "#{Chef::Config[:file_cache_path]}" 
   code <<-EOH
     cp /usr/share/java/mysql-connector-java.jar #{node[:oaicatmuseum][:webapps_dir]}/WEB-INF/lib/
   EOH
#   action :nothing
end

template "#{node[:oaicatmuseum][:webapps_dir]}/WEB-INF/classes/oaicat.properties" do
 source "oaicat.properties.erb"
 variables({
 })
# mode 0644
# owner "root"
# group "root"
 action :create
 #notifies :run, "script[copy_mysql-connector-java]", :immediately
 notifies :restart, "service[tomcat]"
end

template "#{node[:apache2][:httpd_conf_dir]}/oaicatmuseum.conf" do
 source "oaicatmuseum.conf.erb"
 variables({
 })
# mode 0644
# owner "root"
# group "root"
 action :create
 #notifies :run, "script[copy_mysql-connector-java]", :immediately
 notifies :restart, "service[apache2]"
end

