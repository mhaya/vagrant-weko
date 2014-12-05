# -*- coding: utf-8 -*-
#
# Cookbook Name:: rpmforge
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


# CentOS-Base.repoのtemplate
template node[:rpmforge][:repofile] do
 source node[:rpmforge][:repofile_tmpl]
 variables({
 })
 mode 0644
 owner "root"
 group "root"
 action :nothing
end

#yum-plugin-prioritiesのインストール
package "yum-plugin-priorities" do
  package_name node[:rpmforge][:yumplugin]
  action :install
  #インストール時にCentOS-Base.repoのpriority設定をする。
  notifies :create,resources(:template => node[:rpmforge][:repofile])
end

#rpmforge repoのインストール
remote_file "#{Chef::Config[:file_cache_path]}/#{node[:rpmforge][:rpm]}" do
  source node[:rpmforge][:rpm_url]
  checksum node[:rpmforge][:rpm_checksum]
  action :create
end

package "rpmforge" do
  action :install
  provider Chef::Provider::Package::Rpm
  source "#{Chef::Config[:file_cache_path]}/#{node[:rpmforge][:rpm]}" 
end
