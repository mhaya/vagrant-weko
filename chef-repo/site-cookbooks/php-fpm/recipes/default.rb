# -*- coding: utf-8 -*-
# インストール
package "php-fpm" do
  package_name node['php-fpm']['package_name']
  action :install
end

#サービス設定
service "php-fpm" do
  provider node['php-fpm']['service_provider'] if node['php-fpm']['service_provider']
  service_name node['php-fpm']['service_name']
  supports :start => true, :stop => true, :restart => true, :reload => true
  action [ :enable, :start ]
end

#設定
template "#{node['php-fpm']['dir']}/php.ini" do
case node[:platform]
when "ubuntu"
 source "php.ini.erb"
when "centos"
 source "php.ini.centos.erb"
end
 notifies :restart, "service[php-fpm]"
end

case node[:platform]
when "centos"
template "#{node['php-fpm']['conf.d']}/www.conf" do
  source "centos.www.conf.erb"
notifies :restart, "service[php-fpm]"
end
end


directory node['php-fpm']['session_dir'] do
  owner node['php-fpm']['owner']
  group node['php-fpm']['owner']
  mode '0644'
  action :create
end

execute "chown" do
  user "root"
  command "chown -R #{node['php-fpm']['owner']}: #{node['php-fpm']['session_dir']}" 
end

