WekoTool
======

リポジトリソフトウェアWEKOの実行環境を構築します。
共有フォルダにWEKOを展開するので開発にも便利です。

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

ログインID/PASS：

user  ID: admin
password: admin

WEKOインストール先：

/vagrant/vendor/repository

ここは共有ディレクトリ配下。


モジュールインストールは未実施。

その他、WEKOで利用される以下のパッケージを導入済み。

- Mroonga
- wvWare
- xlhtml
- poppler
- ImageMagick
- pdftk
- ffmpeg
- mecab
