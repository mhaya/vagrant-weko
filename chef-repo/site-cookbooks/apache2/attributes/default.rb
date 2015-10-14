case node[:platform]
when "centos"
default[:apache2][:package_name] = "httpd"
default[:apache2][:service_name] = "httpd"
default[:apache2][:dir] = "/etc/httpd"
default[:site][:www_root] = "/var/www/html"
default[:site][:nc2_install] = "/var/www"
default[:site][:www_user] = "apache"
default[:site][:www_group]= "apache"
default[:apache2][:httpd_conf] = "/etc/httpd/conf/httpd.conf"
default[:apache2][:httpd_conf_dir] = "/etc/httpd/conf.d"
default[:apache2][:httpd_conf_tmpl] = "httpd.conf.erb"
default[:site][:fqdn] = "weko"
end


