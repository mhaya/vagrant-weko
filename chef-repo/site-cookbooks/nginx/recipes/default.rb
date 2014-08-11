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

group "www-data" do
     action :modify
     members ['vagrant']
     append true
end

