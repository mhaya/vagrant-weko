#単一の削除アイテムを復活させる

削除アイテムの復活手順は次の通り。

1. [削除アイテムの状態を変更する](#section1)
2. [検索テーブルを再構築する](#section2)
3. [結果を確認する](#section3)

##<a name="section1"/>1. 削除アイテムの状態を変更する。
サーバにログインする。

    $ ssh test

mysql に root でログインする。

    $ scl enable mysql55 'mysql -u root'

    Welcome to the MySQL monitor.  Commands end with ; or \g.
    Your MySQL connection id is 2363
    Server version: 5.5.40 MySQL Community Server (GPL)

    Copyright (c) 2000, 2014, Oracle and/or its affiliates. All rights reserved.

    Oracle is a registered trademark of Oracle Corporation and/or its affiliates. Other names may be trademarks of their respective owners.

    Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

databaseを選択する。

    mysql> use nc2;
    Reading table information for completion of table and column names
    You can turn off this feature to get a quicker startup with -A

    Database changed
    >

ユーザ変数を設定する。@target には復活対象の item id を設定する。@prefix には NetCommons2のテーブルプレフィックスを設定する。

    SET @target=439;
    SET @prefix="nc2";

以下のクエリを実行する。
    
    SET @sql = CONCAT('UPDATE ',@prefix,'_repository_attached_file SET is_delete = 0, del_user_id = "", del_date = "" WHERE item_id=',@target,' AND is_delete=1;');
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    
    SET @sql = CONCAT('UPDATE ',@prefix,'_repository_biblio_info SET is_delete = 0, del_user_id = "", del_date = "" WHERE item_id=',@target,' AND is_delete=1;');
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    
    SET @sql = CONCAT('UPDATE ',@prefix,'_repository_doi_status SET is_delete = 0, del_user_id = "", del_date = "" WHERE item_id=',@target,' AND is_delete=1;');
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    
    SET @sql = CONCAT('UPDATE ',@prefix,'_repository_file SET is_delete = 0, del_user_id = "", del_date = "" WHERE item_id=',@target,' AND is_delete=1;');
    PREPARE stmt FROM @sql;
    EXECUTE stmt;

    SET @sql = CONCAT('UPDATE ',@prefix,'_repository_file_price SET is_delete = 0, del_user_id = "", del_date = "" WHERE item_id=',@target,' AND is_delete=1;');
    PREPARE stmt FROM @sql;
    EXECUTE stmt;

    SET @sql = CONCAT('UPDATE ',@prefix,'_repository_item SET is_delete = 0, del_user_id = "", del_date = "" WHERE item_id=',@target,' AND is_delete=1;');
    PREPARE stmt FROM @sql;
    EXECUTE stmt;

    SET @sql = CONCAT('UPDATE ',@prefix,'_repository_item_attr SET is_delete = 0, del_user_id = "", del_date = "" WHERE item_id=',@target,' AND is_delete=1;');
    PREPARE stmt FROM @sql;
    EXECUTE stmt;

    SET @sql = CONCAT('UPDATE ',@prefix,'_repository_item_external_searchword SET is_delete = 0, del_user_id = "", del_date = "" WHERE item_id=',@target,' AND is_delete=1;');
    PREPARE stmt FROM @sql;
    EXECUTE stmt;

    SET @sql = CONCAT('UPDATE ',@prefix,'_repository_personal_name SET is_delete = 0, del_user_id = "", del_date = "" WHERE item_id=',@target,' AND is_delete=1;');
    PREPARE stmt FROM @sql;
    EXECUTE stmt;

    SET @sql = CONCAT('UPDATE ',@prefix,'_repository_position_index SET is_delete = 0, del_user_id = "", del_date = "" WHERE item_id=',@target,' AND is_delete=1;');
    PREPARE stmt FROM @sql;
    EXECUTE stmt;

    SET @sql = CONCAT('UPDATE ',@prefix,'_repository_ranking SET is_delete = 0, del_user_id = "", del_date = "" WHERE item_id=',@target,' AND is_delete=1;');
    PREPARE stmt FROM @sql;
    EXECUTE stmt;

    SET @sql = CONCAT('UPDATE ',@prefix,'_repository_suffix SET is_delete = 0, del_user_id = "", del_date = "" WHERE item_id=',@target,' AND is_delete=1;');
    PREPARE stmt FROM @sql;
    EXECUTE stmt;

    SET @sql = CONCAT('UPDATE ',@prefix,'_repository_supple SET is_delete = 0, del_user_id = "", del_date = "" WHERE item_id=',@target,' AND is_delete=1;');
    PREPARE stmt FROM @sql;
    EXECUTE stmt;

    SET @sql = CONCAT('UPDATE ',@prefix,'_repository_thumbnail SET is_delete = 0, del_user_id = "", del_date = "" WHERE item_id=',@target,' AND is_delete=1;');
    PREPARE stmt FROM @sql;
    EXECUTE stmt;

    SET @sql = CONCAT('UPDATE ',@prefix,'_repository_attached_file SET is_delete = 0, del_user_id = "", del_date = "" WHERE item_id=',@target,' AND is_delete=1;');
    PREPARE stmt FROM @sql;
    EXECUTE stmt;

##<a name="section2"/>2.検索テーブルを再構築する

[http://localhost/nc2/?action=repository_action_common_reconstruction_search&login_id=[login_id]&password=[password]](http://localhost/nc2/?action=repository_action_common_reconstruction_search&login_id=admin&password=admin)
    
##<a name="section3"/>3.結果を確認する

アイテムが復活しているかを確認する。

[http://localhost/nc2/?action=repository_uri&item_id=[target]](http://localhost/nc2/?action=repository_uri&item_id=439)

詳細ページが表示されれば成功である。

[TOPへ戻る](../)

---
Date: 20141209, last update: 20141209 

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="クリエイティブ・コモンズ・ライセンス" style="border-width:0" src="http://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br /><span xmlns:cc="http://creativecommons.org/ns#" property="cc:attributionName">Masaharu Hayashi</span> を著作者とするこの 作品 は <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">クリエイティブ・コモンズの 表示 4.0 国際 ライセンス</a>で提供されています




