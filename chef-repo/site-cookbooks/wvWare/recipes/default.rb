# -*- coding: utf-8 -*-
#
# Cookbook Name:: wvWare
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

case node[:platform]
when 'centos'
  if node["platform_version"].to_i == 6
    
    # wvのインストール
    package "wvWare" do
      package_name node[:wvWare][:pkg_name]
      action :install
    end
    
  elsif node["platform_version"].to_i == 7

    ## コンパイルに必要なライブラリ
    node[:wvWare][:require_pkgs].each do |pkg|
      package "#{pkg}" do
        action :install
      end
    end
  
    ## wvWareのダウンロード
    remote_file "#{Chef::Config[:file_cache_path]}/#{node[:wvWare][:version]}.tar.gz" do
      source node[:wvWare][:remote_uri]
      checksum node[:wvWare][:checksum]
      action :create
    end
    
    bash "install wvWare" do
      user     "root"
      cwd      "#{Chef::Config[:file_cache_path]}"
      not_if   "ls /usr/local/lib/libwv.so"
      code   <<-EOH
        tar xzf #{node[:wvWare][:version]}.tar.gz
        cd #{node[:wvWare][:version]}
        ./configure
        make
        make install
      EOH
    end
  end
end


