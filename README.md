WekoTool
======

WEKOテスト・開発環境構築用

##実行環境
* virtualbox
 * https://www.virtualbox.org/wiki/Downloads
* vagrant
 * http://www.vagrantup.com/downloads.html
* Ruby
 * Bundler

動作確認バージョン

| software  | version    |
|-----------|------------|
|Vagrant    |1.6.3       |
|VirtualBox |4.3.14r95030|
|Ruby       |2.1.1p76    |
|Bundler    |1.6.1       |

##環境構築
	bundle install --path vendor/bundle
	bundle exec knife configure
	vagrant up
	vagrant ssh-config --host test >> ~/.ssh/config
	cd chef-repo
	bundle exec knife solo prepare vagrant@test
	vagrant sandbox on
	bundle exec knife solo cook test

## Net Commons
install先：
/usr/share/nginx/NetCommons-2.4.2.0

http://localhost:8080/nc2

user  ID: admin
password: admin





