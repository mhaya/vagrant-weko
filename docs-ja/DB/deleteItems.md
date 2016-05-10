#複数アイテムを完全に削除する

手順：

1. [テーブルからアイテムを削除する](#sec1)
2. [削除結果を確認する](#sec2)

## 1. テーブルからアイテムを削除する<a name="sec1"/>

サーバにSSH経由でログインする。

    ssh test

mysqlにログインする。

    scl enable mysql55 "mysql -u root"

データベースを選択する。

    use nc2

ユーザ変数を定義する。値は適宜修正する。

    SET @start = 32;
    SET @end = 531;
    SET @prefix ='nc2'; 
    
以下のクエリを実行し、テーブルから複数アイテムを削除する。
    
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_attached_file WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
	PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_biblio_info WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_doi_status WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_file WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_file_price WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_filecleanup_deleted_file WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_item WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_item_attr WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_item_external_searchword WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_personal_name WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_position_index WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_ranking WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_search_allmetadata WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_search_author WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_search_bsh WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_search_contributor WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt; 
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_search_coverage WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_search_date WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_search_dateofgranted WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_search_dateofissued WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_search_dateofissued_ymd WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_search_ddc WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_search_degreename WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_search_description WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_search_external_searchword WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_search_filedata WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_search_format WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_search_fulltexturl WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_search_grantid WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_search_grantor WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_search_ichushi WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_search_identifier WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_search_isbn WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_search_issn WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_search_jtitle WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_search_keyword WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_search_language WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_search_lcc WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_search_lcsh WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_search_mesh WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_search_naid WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_search_ncid WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_search_ndc WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_search_ndlc WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_search_ndlsh WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_search_niisubject WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_search_pmid WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_search_publisher WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_search_relation WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_search_rights WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_search_selfdoi WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_search_sort WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_search_textversion WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_search_title WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_search_type WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_search_udc WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_search_update_item WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_search_uri WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_send_feedbackmail_author_id WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_suffix WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_supple WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_thumbnail WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    SET @s = CONCAT('DELETE FROM ',@prefix,'_repository_usagestatistics WHERE item_id >= ',@start,' AND item_id <= ',@end,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    
    SET @s = CONCAT('SELECT @last_item_id:=item_id FROM ',@prefix,'_repository_item ORDER BY item_type_id DESC LIMIT 1');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    
    SET @s = CONCAT('UPDATE ',@prefix,'_repository_item_seq_id SET id = ',@last_item_id,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;

具体的な処理内容は以下のとおりである。

1. item_no が定義されているテーブルから @start から @end までの範囲のitem_no を含むレコードを削除する。
2.  @prefix_repository_item のレコードで最大のitem_no を調べ、@prefix_repository_item_seq_id の id に最大の item_no を設定する。


##2.削除結果を確認する<a name="sec2"/>

WEKOリポジトリにアクセスし、アイテムが削除されていることを確認する。

[http://localhost/nc2/?action=repository_uri&item_id=[@start]](http://localhost/nc2/?action=repository_uri&item_id=32)

以上。

[TOPへ戻る](../)
    
---
Date: 20141209, last update: 20141209 

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="クリエイティブ・コモンズ・ライセンス" style="border-width:0" src="http://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br /><span xmlns:cc="http://creativecommons.org/ns#" property="cc:attributionName">Masaharu Hayashi</span> を著作者とするこの 作品 は <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">クリエイティブ・コモンズの 表示 4.0 国際 ライセンス</a>で提供されています
