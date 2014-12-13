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
	vagrant up
    vagrant ssh-config --host weko >> ~/.ssh/config
	cd chef-repo
	bundle exec knife solo prepare vagrant@weko

好みに応じてsandboxを有効にする。

    sudo vagrant sandbox on

nginxを利用する場合は

    sudo cp $ cp nodes/nginx.json nodes/weko.json

apache2を利用する場合は

    sudo cp $ cp nodes/apache.json nodes/weko.json

最後にknife soloを実行して、環境が出来上がるのを待つ。

	bundle exec knife solo cook weko

##サーバ環境
インストール先：
/usr/share/nginx/NetCommons-2.4.2.0

インストールURL:
http://weko/nc2

ログインID/PASS：

user  ID: admin
password: admin

WEKOインストール先：

/vagrant/vendor/repository

ここは共有ディレクトリ配下。

モジュールインストールは未実施。

WEKOで利用される以下のパッケージを導入済み。

- Mroonga
- wvWare
- xlhtml
- poppler
- ImageMagick
- pdftk
- ffmpeg
- mecab

その他
- tomcat6 
- oaicatmuseum 1.1  http://weko:8080/oaicatmuseum_1.1
