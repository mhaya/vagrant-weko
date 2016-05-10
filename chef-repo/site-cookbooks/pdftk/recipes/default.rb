# -*- coding: utf-8 -*-
#
# Cookbook Name:: pdftk
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


case node[:platform]
when 'centos'
  if node["platform_version"].to_i == 6

    # libgcjのインストール
    package "libgcj" do
      package_name node[:pdftk][:requirement]
      action :install
    end
  
  elsif node["platform_version"].to_i == 7


    %w{gtk2 zip libart_lgpl libXtst}.each do |pkg|
  package pkg do
    action :install
  end
    end
    
    remote_file "#{Chef::Config[:file_cache_path]}/libgcj-4.4.7-16.el6.x86_64.rpm" do
      source "http://ftp.riken.jp/Linux/centos/6.7/os/x86_64/Packages/libgcj-4.4.7-16.el6.x86_64.rpm"
      checksum "fab6b9cd9c5b9adc7e41f93417dcf7558fb122a4149496a20fc93642f2f7fa6e"
      action :create
    end


    remote_file "#{Chef::Config[:file_cache_path]}/gmp-4.3.1-7.el6_2.2.x86_64.rpm" do
      source "http://ftp.riken.jp/Linux/centos/6/os/x86_64/Packages/gmp-4.3.1-7.el6_2.2.x86_64.rpm"
      checksum "fab6b9cd9c5b9adc7e41f93417dcf7558fb122a4149496a20fc93642f2f7fa6e"
      action :create
        end


    bash "install libgcj" do
      user "root"
      code <<-EOS
       rpm -iv --force "#{Chef::Config[:file_cache_path]}/gmp-4.3.1-7.el6_2.2.x86_64.rpm"
       rpm -iv --force "#{Chef::Config[:file_cache_path]}/libgcj-4.4.7-16.el6.x86_64.rpm"
      EOS
    end

  end

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
