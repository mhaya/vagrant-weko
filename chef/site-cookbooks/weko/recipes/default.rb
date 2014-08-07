#
# Cookbook Name:: weko
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
WEKO_DIR="/var/www/nc2/html/webapp/modules/repository"

subversion "co weko" do
    repository "http://forge.at.nii.ac.jp/svn/nc/repository/trunk"
    destination "#{WEKO_DIR}"
    action :checkout
end

execute "change weko dir" do
    cwd "#{WEKO_DIR}"
    command "chown -R www-data:www-data #{WEKO_DIR}"
end




