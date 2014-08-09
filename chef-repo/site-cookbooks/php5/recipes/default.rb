# -*- coding: utf-8 -*-
pkg_name = "php5"

case node["platform"]
when "ubuntu"
  pkg_name = "php5"
end

# インストール
package "#{pkg_name}" do
  action :install
end

