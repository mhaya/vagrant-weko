default['site']['www_srv']="nginx"
default['site']['www_root']="/usr/share/nginx/html"


case node['platform']
when "ubuntu"
default['site']['www_user']="www-data"
default['site']['www_group']="www-data"
default['nginx']['package_name'] = "nginx"
default['nginx']['service_name'] = "nginx"
default['nginx']['dir'] = "/etc/nginx"

#else
#set['nginx']['package'] = "nginx"
when "centos"
default['site']['www_user']="nginx"
default['site']['www_group']="nginx"
default['nginx']['package_name'] = "nginx"
default['nginx']['service_name'] = "nginx"
default['nginx']['dir'] = "/etc/nginx"

#else
#set['nginx']['package'] = "nginx"
end
