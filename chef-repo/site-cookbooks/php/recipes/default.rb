# -*- coding: utf-8 -*-

#default設定ファイル
template node[:php][:php_ini] do
 source "#{node[:php][:php_ini_tmpl]}"
 variables({
 })
 mode 0644
 owner "root"
 group "root"
 action :nothing
# notifies :restart, "service[#{node[:site][:www_srv]}]"
end


package node[:php][:package] do
  action :install
  notifies :create,resources(:template => "#{node[:php][:php_ini]}" )
  notifies :restart, "service[#{node[:site][:www_srv]}]"
end

# インストール
node[:php][:install_packages].each do |pkg|
  package "#{pkg}" do
    action :install
  end
end

