# coding: utf-8
case node['platform']
when "ubuntu"
default['mysql']['package_name'] = "mysql-server"
default['mysql']['service_name'] = "mysql"
#default['nginx']['dir'] = "/etc/nginx"
#default['nginx']['root_dir'] = "/usr/share/nginx/html"
#else
#set['nginx']['package'] = "nginx"
when "centos"
default['mysql']['package_name'] = "mysql-server"
default['mysql']['service_name'] = "mysqld"
#default['nginx']['dir'] = "/etc/nginx"
#default['nginx']['root_dir'] = "/usr/share/nginx/html"
#else
#set['nginx']['package'] = "nginx"

  if node["platform_version"].to_i == 6
    # mysql コマンドの設定
    default['mysql']['mysql_cmd'] = "/opt/rh/mysql55/root/usr/bin/mysql"
    default['mysql']['mysqladmin_cmd']="/opt/rh/mysql55/root/usr/bin/mysqladmin"
  elsif node["platform_version"].to_i == 7
    # mysql コマンドの設定
    default['mysql']['mysql_cmd'] = "/usr/bin/mysql"
    default['mysql']['mysqladmin_cmd']="/usr/bin/mysqladmin"
  end

end
