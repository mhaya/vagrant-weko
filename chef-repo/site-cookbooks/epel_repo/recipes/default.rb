#
# Cookbook Name:: epel_repo
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "epel_repo" do
  package_name node[:epel_repo][:pkg_name]
  action :install
end
