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
end
