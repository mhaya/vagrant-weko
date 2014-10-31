# -*- coding: utf-8 -*-
# インストール
package "mysql" do
  package_name node['mysql']['package_name']
  action :install
end

# サービス設定
service "mysql" do
  service_name node['mysql']['service_name']
  if node['platform'] == "ubuntu"
    provider Chef::Provider::Service::Init::Debian
  end
  supports :status => true, :restart => true, :reload => true
  # 自動起動on
  action [ :start, :enable ]
end
