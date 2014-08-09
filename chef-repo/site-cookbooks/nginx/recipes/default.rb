# -*- coding: utf-8 -*-

pkg_name = "nginx"

case node["platform"]
when "ubuntu"
  pkg_name = "nginx"
end

# インストール
package "#{pkg_name}" do
    action :install
end

# サービスの有効化
service "#{pkg_name}" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end

template "/etc/nginx/sites-available/default" do
 source "default.erb"
end
