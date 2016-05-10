# -*- encoding: utf-8 -*-

#
# Cookbook Name:: mroonga
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

case node[:platform]
when "centos"
    if node["platform_version"].to_i == 6
      # Software Collectionのインストール
      package "SCL" do
        package_name node[:mroonga][:scl_pkg]
        action :install
      end
    end
end

# groongaのインストール
remote_file "#{Chef::Config[:file_cache_path]}/#{node[:mroonga][:groonga_file]}" do
  source node[:mroonga][:groonga_url]
  checksum node[:mroonga][:gronnga_checksum]
  action :create
end

package "groonga" do
  action :install
  provider Chef::Provider::Package::Rpm
  source "#{Chef::Config[:file_cache_path]}/#{node[:mroonga][:groonga_file]}" 
end

# mysqlのインストール
node[:mroonga][:mysql_pkgs].each do |pkg|
  package "#{pkg}" do
    action :install
  end
end


# サービス設定
service "mysqld" do
  service_name node[:mroonga][:service]
  if node['platform'] == "ubuntu"
    provider Chef::Provider::Service::Init::Debian
  end
  supports :status => true, :restart => true, :reload => true
  # 自動起動on
  action [ :start, :enable ]
end


# mysql起動後、mroongaのインストール
node[:mroonga][:packages].each do |pkg|
  package "#{pkg}" do
    action :install
  end
end

