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

##インストール
<code>bundle install --path vendor/bundle</code>

<code>bundle exec knife configure</code>

<code>vagrant up</code>

<code>vagrant ssh-config --host test >> ~/.ssh/config</code>

<code>bundle exec knife solo prepare vagrant@test</code>

<code>cd chef-repo</code>

<code>bundle exec knife solo cook test</code>



