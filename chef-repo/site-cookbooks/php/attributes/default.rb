case node['platform']
when 'ubuntu'
default['php']['package']="php5"
default['php']['install_packages'] = %w[php5-common php5-cli php5-xml php5-mbstring]
default['php']['apc']['install_packages'] = %w[php5-apcu php5-gd]
default['php']['mysql']['install_packages'] = %w[php5-mysql]
default['php']['php.ini']="/etc/php.ini"
default['php']['php.ini_tmpl']="php.ini.centos.erb"
when 'centos'
default['php']['package']="php"
default['php']['install_packages'] = %w[php-common php-cli php-xml php-mbstring] 
default['php']['apc']['install_packages'] = %w[php-apcu php-gd]
default['php']['mysql']['install_packages'] = %w[php-mysql]
default['php']['php.ini']="/etc/php.ini"
default['php']['php.ini_tmpl']="php.ini.centos.erb"
end
