#削除アイテムの復活

削除アイテムの復活手順は次の通り。

1. [削除アイテムの状態変更](#section1)
2. [検索テーブルの再構築](#section2)
3. [確認](#section3)

##<a name="section1"/>1. 削除アイテムの状態変更
テーブルを更新し、削除アイテムの状態を削除前の状態に戻す。

ユーザ変数「@target、@prefix」は環境に応じて編集すること。

    SET @target=439;
    SET @prefix="nc2";    
    
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

##<a name="section2"/>2.検索テーブルの再構築

[http://localhost/nc2/?action=repository_action_common_reconstruction_search&login_id=[login_id]&password=[password]](http://localhost/nc2/?action=repository_action_common_reconstruction_search&login_id=admin&password=admin)
    
##<a name="section3"/>3.確認

[http://localhost/nc2/](http://localhost/nc2/)


