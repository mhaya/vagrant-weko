# -*- coding: utf-8 -*-
default[:mroonga][:scl_pkg] = "centos-release-SCL"
default[:mroonga][:groonga_file] = "groonga-release-1.1.0-1.noarch.rpm"
default[:mroonga][:groonga_checksum]="eff0e8124eb459dc77170109f82e318478708686942d1a1ddfc905ddac0a4f58"
default[:mroonga][:groonga_url] =  "http://packages.groonga.org/centos/groonga-release-1.1.0-1.noarch.rpm"
default[:mroonga][:mysql_pkgs] = %w[mysql55-mysql mysql55-mysql-server]
default[:mroonga][:packages] = %w[mysql55-mroonga groonga-tokenizer-mecab]
default[:mroonga][:service]="mysql55-mysqld"
# mysql コマンドの設定
default['site']['mysql_cmd'] = "/opt/rh/mysql55/root/usr/bin/mysql"

