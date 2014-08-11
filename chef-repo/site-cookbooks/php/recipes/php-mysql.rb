# -*- coding: utf-8 -*-
# インストール
node['php']['mysql']['install_packages'].each do |pkg|
  package "#{pkg}" do
    action :install
  end
end

