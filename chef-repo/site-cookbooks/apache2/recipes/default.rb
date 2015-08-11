# -*- coding: utf-8 -*-

#default設定ファイル
template node['apache2']['httpd.conf'] do
 source "#{node['apache2']['httpd.conf_tmpl']}"
 variables({
:fqdn => node[:site][:fqdn] 
 })
 mode 0644
 owner "root"
 group "root"
 action :nothing
end


# インストール
package "apache2" do
  package_name node['apache2']['package_name']
  action :install
  notifies :create,resources(:template => node['apache2']['httpd.conf'] )
end

# サービスの有効化
service "apache2" do
  service_name node['apache2']['service_name']
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end

group node['site']['www_user'] do
     action :modify
     members ['vagrant']
     append true
end

