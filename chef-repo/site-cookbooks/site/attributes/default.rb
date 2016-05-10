case node[:platform]
when "centos"
  if node["platform_version"].to_i == 6
    default[:site][:hostname]="weko"
    default[:site][:port]=80
    default[:site][:www_srv]="apache2"
    default[:site][:www_root]="/var/www/html"
    default[:site][:www_user]="apache"
    default[:site][:www_group]="apache"
    default[:site][:nc2_install]="/var/www"
  end
end
