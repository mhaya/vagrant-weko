# -*- coding: utf-8 -*-
#
# Cookbook Name:: screen
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# パッケージをインストールする
package "screen" do
 package_name node[:screen][:pkg_name]
 action :install
end
