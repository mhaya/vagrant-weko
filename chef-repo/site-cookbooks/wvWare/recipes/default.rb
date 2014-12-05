# -*- coding: utf-8 -*-
#
# Cookbook Name:: wvWare
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# wvのインストール
package "wvWare" do
  package_name node[:wvWare][:pkg_name]
  action :install
end
