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

| OS        | Version    |
|-----------|------------|
| CentOS    | 6.5        |
| ~~Ubuntu~~    | ~~14.04~~      |

| software  | version    |
|-----------|------------|
|Vagrant    |1.6.3       |
|VirtualBox |4.3.14r95030|
|Ruby       |2.1.1p76    |
|Bundler    |1.6.1       |

##環境構築
Vagranfileを編集し、config.vm.boxあたりを編集する。

	bundle install --path vendor/bundle
	bundle exec knife configure
	sudo vagrant up
    sudo vagrant ssh-config --host test >> ~/.ssh/config
	cd chef-repo
	bundle exec knife solo prepare vagrant@test

(sudoを用いてるのは127.0.0.1:80へのポートフォワーディングを実施しているため)

好みに応じてsandboxを有効にする。

    sudo vagrant sandbox on

nginxを利用する場合は

    sudo cp $ cp nodes/nginx.json nodes/test.json

apache2を利用する場合は

    sudo cp $ cp nodes/apache.json nodes/test.json

最後にknife soloを実行して、環境が出来上がるのを待つ。

	bundle exec knife solo cook test

##サーバ環境
インストール先：
/usr/share/nginx/NetCommons-2.4.2.0

インストールURL:
http://localhost/nc2

インストールURLを変更する場合は、
グローバル・ローカルの両方で有効な名前を付けること。
（※WEKO内部で自身に対してHTTP/HTTPS通信を行うため）

OAI-PMHを利用する場合は、
デフォルトポート以外は使用できない。
（OAI PMHのidentifierはポート番号に対応しない。）

ログインID/PASS：

user  ID: admin
password: admin

WEKOインストール先：

/vagrant/vendor/repository

ここは共有ディレクトリ配下。


モジュールのインストールは実施していないので、
管理画面からインストールする。
