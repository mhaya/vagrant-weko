# -*- coding: utf-8 -*-
#
# Cookbook Name:: ffmpeg
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "ffmpeg" do
  package_name node[:ffmpeg][:pkg_name]
  action :install
end
