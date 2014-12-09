# 単一アイテムを完全に削除する

1. レコードからアイテムを削除する
2. 削除結果を確認する

## <a name="sec1"/>レコードからアイテムを削除する

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

ユーザ変数を定義する。@target には削除対象のitem_noを指定する。@prefix にはNetCommons2のテーブルプレフィックスを指定する。

    SET @target=33;
    SET @prefix="nc2";

以下のクエリを実行し、テーブルからアイテムを削除する。

    SET @s = CONCAT("DELETE FROM ",@prefix,"_repository_attached_file WHERE item_id = ",@target,";");
    PREPARE stmt FROM @s;
    EXECUTE stmt;

    SET @s = CONCAT("DELETE FROM ",@prefix,"_repository_biblio_info WHERE item_id = ",@target,";");
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    
    SET @s = CONCAT("DELETE FROM ",@prefix,"_repository_doi_status WHERE item_id = ",@target,";");
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    
    SET @s = CONCAT("DELETE FROM ",@prefix,"_repository_file WHERE item_id = ",@target,";");
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    
    SET @s = CONCAT("DELETE FROM ",@prefix,"_repository_file_price WHERE item_id = ",@target,";");
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    
	SET @s = CONCAT("DELETE FROM ",@prefix,"_repository_item WHERE item_id = ",@target,";");
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    
    SET @s = CONCAT("DELETE FROM ",@prefix,"_repository_item_attr WHERE item_id = ",@target,";");
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    
    SET @s = CONCAT("DELETE FROM ",@prefix,"_repository_item_external_searchword WHERE item_id = ",@target,";");
    PREPARE stmt FROM @s;
    EXECUTE stmt;

    SET @s = CONCAT("DELETE FROM ",@prefix,"_repository_personal_name WHERE item_id = ",@target,";");
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    
    SET @s = CONCAT("DELETE FROM ",@prefix,"_repository_position_index WHERE item_id = ",@target,";");
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    
    SET @s = CONCAT("DELETE FROM ",@prefix,"_repository_ranking WHERE item_id = ",@target,";");
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    
    SET @s = CONCAT("DELETE FROM ",@prefix,"_repository_suffix WHERE item_id = ",@target,";");
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    
    SET @s = CONCAT("DELETE FROM ",@prefix,"_repository_supple WHERE item_id = ",@target,";");
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    
    SET @s = CONCAT("DELETE FROM ",@prefix,"_repository_thumbnail WHERE item_id = ",@target,";");
    PREPARE stmt FROM @s;
    EXECUTE stmt;

mysql からログアウトし、ssh からも抜ける。

    mysql> exit
    Bye
    $ exit
    logout
    Connection to 127.0.0.1 closed.


## <a name="sec2"/>削除結果を確認する

アイテムが削除されているかを確認する。

[http://localhost/nc2/?action=repository_uri&item_id=[target]](http://localhost/nc2/?action=repository_uri&item_id=33)

「アイテムが削除されています」と表示されれば成功である。

以上。

[TOPへ戻る](../)

---
Date: 20141209, last update: 20141209 

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="クリエイティブ・コモンズ・ライセンス" style="border-width:0" src="http://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br /><span xmlns:cc="http://creativecommons.org/ns#" property="cc:attributionName">Masaharu Hayashi</span> を著作者とするこの 作品 は <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">クリエイティブ・コモンズの 表示 4.0 国際 ライセンス</a>で提供されています






