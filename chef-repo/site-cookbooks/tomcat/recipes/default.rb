#
# Cookbook Name:: oaicatmuseum
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


node[:tomcat][:pkgs].each do |pkg|
  package "#{pkg}" do
    action :install
  end
end

service "tomcat" do
  service_name node[:tomcat][:service_name]
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end

