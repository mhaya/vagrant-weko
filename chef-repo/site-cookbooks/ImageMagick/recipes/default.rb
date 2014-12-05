# -*- coding: utf-8 -*-
#
# Cookbook Name:: ImageMagick
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# インストール
package "ImageMagick" do
 package_name node[:ImageMagick][:pkg_name]
 action :install
end
