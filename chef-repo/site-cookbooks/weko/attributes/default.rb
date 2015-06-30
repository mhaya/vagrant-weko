#default['weko']['filename'] = "weko2.1.1.tar.gz"
default['weko']['filename'] = "weko2.2.0.tar.gz"
#default['weko']['remote_uri'] = "http://weko.at.nii.ac.jp/?action=cabinet_action_main_download&block_id=14&room_id=1&cabinet_id=3&file_id=75&upload_id=269"
default['weko']['remote_uri']="http://weko.at.nii.ac.jp/?action=cabinet_action_main_download&block_id=14&room_id=1&cabinet_id=3&file_id=97&upload_id=379"
#default[:weko][:checksum]="44c8d4dd1db28e70e8f8e8089dd484043fca9d39f78fd18fd0245379c9d6699d"
default[:weko][:checksum]="3881d3256bada077eaece6eb137c4b4f81fbd5f90ffcac4206f566c0aeb8d75c"
default['weko']['install_dir'] = "/vagrant/vendor"
default['weko']['dir'] = "#{node['weko']['install_dir']}/repository"
default[:weko][:module_name] ="repository"
#case [:platform]
#when "ubuntu"
# default['weko']['owner'] = "#{node['site']['www_user']}"
#when "centos"
# default['weko']['owner'] = "#{node['site']['www_user']}"
#end


