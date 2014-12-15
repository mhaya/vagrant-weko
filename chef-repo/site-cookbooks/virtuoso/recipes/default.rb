#
# Cookbook Name:: virtuoso
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# 
node[:virtuoso][:depends_pkgs].each do |pkg|
  package "#{pkg}" do
    action :install
  end
end

script "install_virtuoso" do
   interpreter "bash"
   user "root"
   timeout 36000
   cwd "#{Chef::Config[:file_cache_path]}" 
   code <<-EOH
   git clone --depth=1 https://github.com/openlink/virtuoso-opensource.git
   cd virtuoso-opensource
   ./autogen.sh
   ./configure --prefix=/usr/local/ --with-readline 
   make
   make install
   EOH
end


# virtuoso-t +configfile /usr/local/var/lib/virtuoso/db/virtuoso.ini
