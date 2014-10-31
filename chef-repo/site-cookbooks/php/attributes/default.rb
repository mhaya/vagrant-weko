case node['platform']
when 'ubuntu'
default['php']['install_packages'] = %w[php5-common php5-cli php5-xml]
default['php']['apc']['install_packages'] = %w[php5-apcu php5-gd]
default['php']['mysql']['install_packages'] = %w[php5-mysql]
when 'centos'
default['php']['install_packages'] = %w[php-common php-cli php-xml]
default['php']['apc']['install_packages'] = %w[php-apcu php-gd]
default['php']['mysql']['install_packages'] = %w[php-mysql]
end

