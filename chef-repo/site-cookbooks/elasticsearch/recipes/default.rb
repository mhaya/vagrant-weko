# -*- coding: utf-8 -*-
#
# Cookbook Name:: elasticsearch
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# test : bundle exec knife solo cook weko -W -o elasticsearch::default

# 必要パッケージのインストール
node[:elasticsearch][:pkgs].each do |pkg|
  package "#{pkg}" do
    action :install
  end
end

# elasticsearchのダウンロード
remote_file "#{node[:elasticsearch][:filename]}" do
  source node[:elasticsearch][:remote_uri]
  path "#{Chef::Config[:file_cache_path]}/#{node[:elasticsearch][:filename]}"
  checksum node[:elasticsearch][:checksum]
  action :create
end

# パッケージの展開
script "unpack_#{node[:elasticsearch][:filename]}" do
  interpreter "bash"
  user "root"
  code <<-EOL
  install -d #{node[:elasticsearch][:install_dir]}
  tar zxvf #{Chef::Config[:file_cache_path]}/#{node[:elasticsearch][:filename]} -C #{node[:elasticsearch][:install_dir]}
  EOL
end

# elasticsearch service wrapperのダウンロード
remote_file "#{Chef::Config[:file_cache_path]}/#{node[:elasticsearch_srv][:filename]}" do
  source "#{node[:elasticsearch_srv][:remote_uri]}"
  path "#{Chef::Config[:file_cache_path]}/#{node[:elasticsearch_srv][:filename]}"
  checksum node[:elasticsearch_srv][:checksum]
  action :create
end

# service wrapperの展開
script "unpack_#{node[:elasticsearch_srv][:filename]}" do
  not_if {File.exists?("#{node[:elasticsearch_srv][:install_dir]}/elasticsearch-servicewrapper-master")}
  interpreter "bash"
  user "root"
  code <<-EOL
  install -d #{node[:elasticsearch_srv][:install_dir]}
  unzip #{Chef::Config[:file_cache_path]}/#{node[:elasticsearch_srv][:filename]} -d #{node[:elasticsearch_srv][:install_dir]}
  EOL
end

#service wrapperのインストール
script "install_#{node[:elasticsearch_srv][:filename]}" do
  not_if {File.exists?("/etc/init.d/elasticsearch")}
  interpreter "bash"
  user "root"
  code <<-EOL
  cd #{node[:elasticsearch_srv][:install_dir]}
  mv *servicewrapper*/service bin/
  bin/service/elasticsearch install
  EOL
end

# サービスの有効化
service "#{node[:elasticsearch_srv][:service_name]}" do
  service_name node[:elasticsearch_srv][:service_name]
  supports :status => true, :restart => true, :reload => true
#  action :nothing
end
