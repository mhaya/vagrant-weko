vagrant-weko
======

NIIが開発したリポジトリソフトウェア WEKO をインストールした環境を構築します。

WEKOを使った実験や開発を行う環境を、手軽に構築することを目的としています。

導入バージョン: weko2.2.3.tar.gz

##必要ソフトウェア

* Virtualbox
 * https://www.virtualbox.org/wiki/Downloads
* Vagrant
 * http://www.vagrantup.com/downloads.html
* Ruby
 * Bundler

動作確認バージョン

| software  | version    |
|-----------|------------|
|Vagrant    |1.7.2       |
|VirtualBox |4.3.28 |
|Ruby       |2.1.4p265   |
|Bundler    |1.7.4      |

その他、vagrant sahara pluginをインストールしておくと便利です。

##使い方

```
git clone https://github.com/mhaya/vagrant-weko.git
cd vagrant-weko/
bundle install --path vendor/bundle
bundle exec knife configure
vagrant up
vagrant ssh-config --host weko >> ~/.ssh/config
cd chef-repo/
bundle exec knife solo prepare weko
bundle exec knife solo cook weko nodes/weko.json
```

以上でNC2のインストールまでが完了します。

以下のURLにアクセスし、WEKOモジュールのインストールを行ってください。

http://weko/nc2

管理ユーザのIDはadminです。パスワードは管理ユーザIDと同じです。

## 環境説明

apache2:

- /etc/httpd/conf/httpd.conf

mysql:

- /etc/my.cnf

php:

- /etc/httpd/conf.d/php.ini
- /etc/php.ini

Netcommons2:

- /usr/share/nginx/NetCommons-2.4.2.1

WEKO:

- /vagrant/vendor/repository

WEKO関係のパッケージ：

- Mroonga
- poppler
- wvWare
- xlhtml
- mecab
- ImageMagick
- pdftk
- ffmpeg

以下はあそび目的のパッケージ。不要なら run_list から除く

- recipe[tomcat]
- recipe[oaicatmuseum]
- recipe[virtuoso]
- recipe[elasticsearch]


tomcat6:
- /usr/share/tomcat6

oaicatmuseum:
- /usr/share/tomcat6/webapps/oaicatmuseum
- /etc/httpd/conf.d/oaicatmuseum.conf
- http://weko/oaicatmuseum

virtuoso-opensource:
- /usr/local/
- http://weko:8890/

elasticsearch
- /usr/local
- http://weko:9200
