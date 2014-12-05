# -*- coding: utf-8 -*-
#
# Cookbook Name:: pdftk
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# libgcjのインストール
package "libgcj" do
 package_name node[:pdftk][:requirement]
 action :install
end

# rpmのダウンロード
remote_file "#{Chef::Config[:file_cache_path]}/#{node[:pdftk][:rpm]}" do
  source node[:pdftk][:rpm_url]
  checksum node[:pdftk][:rpm_checksum]
  action :create
end

package "pdftk" do
  action :install
  provider Chef::Provider::Package::Rpm
  source "#{Chef::Config[:file_cache_path]}/#{node[:pdftk][:rpm]}" 
end
