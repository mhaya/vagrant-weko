# -*- coding: utf-8 -*-
case node[:platform]
when "centos"
    if node["platform_version"].to_i == 6
      default[:mroonga][:scl_pkg] = "centos-release-SCL"
      default[:mroonga][:groonga_file] = "groonga-release-1.1.0-1.noarch.rpm"
      default[:mroonga][:groonga_checksum]="eff0e8124eb459dc77170109f82e318478708686942d1a1ddfc905ddac0a4f58"
      default[:mroonga][:groonga_url] =  "http://packages.groonga.org/centos/groonga-release-1.1.0-1.noarch.rpm"
      default[:mroonga][:mysql_pkgs] = %w[mysql55-mysql mysql55-mysql-server]
      default[:mroonga][:packages] = %w[mysql55-mroonga groonga-tokenizer-mecab]
      default[:mroonga][:service]="mysql55-mysqld"
    elsif node["platform_version"].to_i == 7
      default[:mroonga][:groonga_file] = "groonga-release-1.1.0-1.noarch.rpm"
      default[:mroonga][:groonga_checksum]="eff0e8124eb459dc77170109f82e318478708686942d1a1ddfc905ddac0a4f58"
      default[:mroonga][:groonga_url] =  "http://packages.groonga.org/centos/groonga-release-1.1.0-1.noarch.rpm"
      default[:mroonga][:mysql_pkgs] = %w[mariadb mariadb-server]
      default[:mroonga][:packages] = %w[mariadb-mroonga groonga-tokenizer-mecab]
      default[:mroonga][:service]="mariadb"
    end
end
