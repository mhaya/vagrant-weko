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

node[:elasticsearch][:pkgs].each do |pkg|
  package "#{pkg}" do
    action :install
  end
end


#install service
script "install_elasticsearch_service" do
  interpreter "bash"
  user "root"
  code <<-EOL
  cd #{node[:elasticsearch_srv][:install_dir]}
  mv *servicewrapper*/service bin/
  bin/service/elasticsearch install
  EOL
  action :nothing
end


# unpack
script "unpack_elasticsearch_service" do
  interpreter "bash"
  user "root"
  code <<-EOL
  install -d #{node[:elasticsearch_srv][:install_dir]}
  tar zxvf #{Chef::Config[:file_cache_path]}/#{node[:elasticsearch_srv][:filename]} -C #{node[:elasticsearch_srv][:install_dir]}
  EOL
  action :nothing
  notifies :run, resources( :script => 'install_elasticsearch_service')
end


# download 
remote_file "#{node[:elasticsearch_srv][:filename]}" do
  source node[:elasticsearch_srv][:remote_uri]
  path "#{Chef::Config[:file_cache_path]}/#{node[:elasticsearch_srv][:filename]}"
#  checksum node[:elasticsearch_srv][:checksum]
  action :nothing
  notifies :run, resources( :script => 'unpack_elasticsearch_service')
end

# unpack
script "unpack_#{node[:elasticsearch][:filename]}" do
  interpreter "bash"
  user "root"
  code <<-EOL
  install -d #{node[:elasticsearch][:install_dir]}
  tar zxvf #{Chef::Config[:file_cache_path]}/#{node[:elasticsearch][:filename]} -C #{node[:elasticsearch][:install_dir]}
  EOL
  action :nothing
  notifies :create, resources( :remote_file => "#{node[:elasticsearch_srv][:filename]}"), :immediately
end

# download 
remote_file "#{node[:elasticsearch][:filename]}" do
  source node[:elasticsearch][:remote_uri]
  path "#{Chef::Config[:file_cache_path]}/#{node[:elasticsearch][:filename]}"
  checksum node[:elasticsearch][:checksum]
  action :create
  notifies :run, resources( :script => "unpack_#{node[:elasticsearch][:filename]}"), :immediately
end

# サービスの有効化
service "enable_elasticsearch_srv" do
  service_name node[:elasticsearch_srv][:service_name]
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end
