#
# Cookbook Name:: nc2
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

remote_file "download nc2" do
  # path "#{Chef::Config[:file_cache_path]}/NetCommons-2.4.2.0.tar.gz"
  path "/usr/local/NetCommons-2.4.2.0.tar.gz"
  source "http://www.netcommons.org/%E3%83%80%E3%82%A6%E3%83%B3%E3%83%AD%E3%83%BC%E3%83%89/%E3%82%B3%E3%82%A2%E3%83%91%E3%83%83%E3%82%B1%E3%83%BC%E3%82%B8/?action=cabinet_action_main_download&block_id=93&room_id=1&cabinet_id=1&file_id=2467&upload_id=5296"
  action :create_if_missing
end

execute 'extract nc2' do
	# cwd "#{Chef::Config[:file_cache_path]}"
	user "root"
        group "root"

        cwd "/usr/local"
        command "tar zxvf NetCommons-2.4.2.0.tar.gz; chown -R www-data.www-data NetCommons-2.4.2.0"
	not_if do
		# File.directory? "#{Chef::Config[:file_cache_path]}/NetCommons-2.4.2.0"
		File.directory? "/usr/local/NetCommons-2.4.2.0"
	end
end

link "/var/www/nc2" do
 	to "/usr/local/NetCommons-2.4.2.0"
end




