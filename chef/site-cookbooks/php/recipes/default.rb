#
# Cookbook Name:: php
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
%w{php5 php-pear php5-cli php5-common php5-dev php5-gd php5-mysql libapache2-mod-php5 php-apc}.each do |suffix|
     package suffix do
         action :install
     end
end

