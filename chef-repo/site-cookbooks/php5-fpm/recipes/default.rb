# -*- coding: utf-8 -*-
# インストール
pkg_name = "php5-fpm"

case node["platform"]
when "ubuntu"
  pkg_name = "php5-fpm"
end

package "#{pkg_name}" do
  action :install
end

service_provider = nil
if node['platform'] == 'ubuntu' and node['platform_version'].to_f >= 13.10
  service_provider = ::Chef::Provider::Service::Upstart
end

service "#{pkg_name}" do
  provider service_provider if service_provider
  service_name pkg_name
  supports :start => true, :stop => true, :restart => true, :reload => true
  action [ :enable, :start ]
end

template "/etc/php5/fpm/php.ini" do
  source "php.ini.erb"
end

