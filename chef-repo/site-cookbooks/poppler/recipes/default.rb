# -*- coding: utf-8 -*-
#
# Cookbook Name:: poppler
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# インストール
node[:poppler][:pkgs].each do |pkg|
  package "#{pkg}" do
    action :install
  end
end
