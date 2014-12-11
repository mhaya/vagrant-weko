#
# Cookbook Name:: xlhtml
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

node[:xlhtml][:build_pkgs].each do |pkg|
  package "#{pkg}" do
    action :install
  end
end

remote_file "#{Chef::Config[:file_cache_path]}/#{node[:xlhtml][:file]}" do
  source node[:xlhtml][:file_url]
  checksum node[:xlhtml][:file_checksum]
  action :create
end

script "install_xlhtml" do
    interpreter "bash"
    user "root"
    cwd "#{Chef::Config[:file_cache_path]}" 
    code <<-EOH
    tar -zxf #{node[:xlhtml][:file]}
    #cd xlhtml-0.5
    cd xlhtml
    #./configure --prefix=/usr --build=x86-unknown-linux-gnu
    ./configure --prefix=/usr
    make
    make install
    EOH
end
