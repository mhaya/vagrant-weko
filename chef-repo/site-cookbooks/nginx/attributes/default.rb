case node['platform']
when "ubuntu"
default['nginx']['hostname'] = "localhost"
default['nginx']['package_name'] = "nginx"
default['nginx']['service_name'] = "nginx"
default['nginx']['dir'] = "/etc/nginx"
default['nginx']['root_dir'] = "/usr/share/nginx/html"
#else
#set['nginx']['package'] = "nginx"
when "centos"
default['nginx']['hostname'] = "localhost"
default['nginx']['package_name'] = "nginx"
default['nginx']['service_name'] = "nginx"
default['nginx']['dir'] = "/etc/nginx"
default['nginx']['root_dir'] = "/usr/share/nginx/html"
#else
#set['nginx']['package'] = "nginx"
end
