# -*- coding: utf-8 -*-

# インストール
package "nginx" do
  package_name node['nginx']['package_name']
  action :install
end

# サービスの有効化
service "nginx" do
  service_name node['nginx']['service_name']
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end

group node['site']['www_user'] do
     action :modify
     members ['vagrant']
     append true
end


#default設定ファイル
case node[:platform]
when "ubuntu"
template "#{node['nginx']['dir']}/sites-available/default" do
 source "default.erb" 
 variables({
 })
 notifies :restart, "service[nginx]"
end
when "centos"
template "#{node['nginx']['dir']}/conf.d/default.conf" do
 source "default.conf.erb" 
 variables({
 })
 notifies :restart, "service[nginx]"
end
end
