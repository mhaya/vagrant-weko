case node['platform']
when 'ubuntu'
  default['php-fpm']['package_name'] = "php5-fpm"
  default['php-fpm']['service_name'] = "php5-fpm"
  
  default['php-fpm']['service_provider'] = nil
  if node['platform'] == 'ubuntu' and node['platform_version'].to_f >= 13.10
    default['php-fpm']['service_provider'] = ::Chef::Provider::Service::Upstart
  end

  default['php-fpm']['dir'] = "/etc/php5/fpm"
end
