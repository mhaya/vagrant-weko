# -*- coding: utf-8 -*-
#default設定ファイル
template "#{node['nginx']['dir']}/sites-available/default" do
 source "default.erb" 
 notifies :restart, "service[nginx]"
end
