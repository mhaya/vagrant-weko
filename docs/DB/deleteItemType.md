# アイテムタイプを削除する

手順:

1. [アイテムタイプ削除の可否を確認する](#sec1)
2. [テーブルからアイテムタイプを削除する](#sec2)
3. [削除結果を確認する](#sec3)


##アイテムタイプ削除の可否を確認する<a name="sec1"/>

サーバにログインする。

    ssh test

mysql に root でログインし、データベースに接続する。

    scl enable mysql55 'mysql -u root nc2'

mysqlでの作業：

削除するアイテムタイプの item_type_id を確認する。

    SET @prefix ='nc2';
    SET @s = CONCAT('SELECT item_type_id,item_type_name FROM ',@prefix,'_repository_item_type WHERE item_type_id< 10000;');
	PREPARE stmt from @s;
	EXECUTE stmt;

念のため当該の item_type_id が利用されていないかを確認する。

    SET @target=2;
    SET @s = CONCAT('SELECT COUNT(item_id) FROM ',@prefix,'_repository_item WHERE item_type_id = ',@target,';');
	PREPARE stmt from @s;
	EXECUTE stmt;
    
COUNT結果が0件であればアイテムタイプを削除可能である。

##テーブルからアイテムタイプを削除する<a name="sec2"/>

    SET @target_id = 2;
    SET @prefix ='nc2'; 

    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_item_attr_type WHERE item_type_id = ', @target_id,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;

    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_item_type WHERE item_type_id = ', @target_id,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;

    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_item_type_name_multilanguage WHERE item_type_id = ', @target_id,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    
    SET @s = CONCAT('SELECT @last_item_type_id:=item_type_id FROM ',@prefix,'_repository_item_type WHERE item_type_id < 10000 ORDER BY item_type_id DESC LIMIT 1;');
    PREPARE stmt FROM @s;
    EXECUTE stmt;

    SET @s = CONCAT('UPDATE ',@prefix,'_repository_item_type_seq_id set id = ',@last_item_type_id,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;

## 削除結果を確認する <a name="sec3"/>

[http://localhost/nc2/](http://localhost/nc2/)

WEKOのアイテム登録のアイテムタイプ選択項目から、
当該のアイテムタイプが消えていれば成功である。

以上。

[TOPに戻る](../../)

---
create:20141209 ,last update:20141209

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="クリエイティブ・コモンズ・ライセンス" style="border-width:0" src="http://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br /><span xmlns:cc="http://creativecommons.org/ns#" property="cc:attributionName">Masaharu Hayashi</span> を著作者とするこの 作品 は <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">クリエイティブ・コモンズの 表示 4.0 国際 ライセンス</a>で提供されています
