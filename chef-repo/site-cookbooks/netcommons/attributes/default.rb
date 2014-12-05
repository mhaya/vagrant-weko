default['netcommons']['filename'] = "NetCommons-2.4.2.0.tar.gz"
#default['netcommons']['install_dir'] = "/usr/share/nginx"
default['netcommons']['remote_uri'] = "http://www.netcommons.org/%E3%83%80%E3%82%A6%E3%83%B3%E3%83%AD%E3%83%BC%E3%83%89/%E3%82%B3%E3%82%A2%E3%83%91%E3%83%83%E3%82%B1%E3%83%BC%E3%82%B8/?action=cabinet_action_main_download&block_id=93&room_id=1&cabinet_id=1&file_id=2467&upload_id=5296"
default[:nc2][:checksum] = "a325fbf939d29e6a1b939f63c72ddc415ac36d3838d3e6d8b043446496af39a3"
default['netcommons']['dir'] = "#{node['site']['nc2_install']}/NetCommons-2.4.2.0"
default['netcommons']['home'] = "#{node['netcommons']['dir']}/html/htdocs"
default[:nc2][:module_dir] = "#{node['netcommons']['dir']}/html/webapp/modules"

#case node["platform"]
#when "ubuntu"
#default['netcommons']['username'] = "www-data"
#default['netcommons']['groupname'] = "www-data"
#when "centos"
#default['netcommons']['username'] = "nginx"
#default['netcommons']['groupname'] = "nginx"
#end
