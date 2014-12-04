# -*- coding: utf-8 -*-

#default設定ファイル
template node['php']['php.ini'] do
 source "#{node['php']['php.ini_tmpl']}"
 variables({
 })
 mode 0644
 owner "root"
 group "root"
 action :nothing
end


package node['php']['package'] do
  action :install
  notifies :create,resources(:template => "#{node['php']['php.ini']}" )
end

# インストール
node['php']['install_packages'].each do |pkg|
  package "#{pkg}" do
    action :install
  end
end

