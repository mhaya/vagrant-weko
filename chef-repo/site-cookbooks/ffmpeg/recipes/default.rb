# -*- coding: utf-8 -*-
#
# Cookbook Name:: ffmpeg
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "nux_dextop" do
  action :nothing
  provider Chef::Provider::Package::Rpm
  source "#{Chef::Config[:file_cache_path]}/#{node[:nux_dextop][:rpm]}" 
end

package "ffmpeg" do
  package_name node[:ffmpeg][:pkg_name]
  action :nothing
end

remote_file "#{Chef::Config[:file_cache_path]}/#{node[:nux_dextop][:rpm]}" do
  source node[:nux_dextop][:rpm_url]
  checksum node[:nux_dextop][:rpm_checksum]
  action :create
  notifies :install, resources( :package => "nux_dextop" )
  notifies :install, resources( :package => "ffmpeg" )
end

