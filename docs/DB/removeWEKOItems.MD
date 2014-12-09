# アイテムを完全に削除する

set @target=434;
set @prefix="nc2";

SELECT item_id,is_delete from nc2_repository_attached_file where item_id=@target;
SELECT item_id,is_delete from nc2_repository_biblio_info where item_id=@target;
SELECT item_id,is_delete from nc2_repository_doi_status where item_id=@target;
SELECT item_id,is_delete from nc2_repository_file where item_id=@target;
SELECT item_id,is_delete from nc2_repository_file_price where item_id=@target;
SELECT item_id,is_delete from nc2_repository_item where item_id=@target;
SELECT item_id,is_delete from nc2_repository_item_attr where item_id=@target;
SELECT item_id,is_delete from nc2_repository_item_external_searchword where item_id=@target;
SELECT item_id,is_delete from nc2_repository_personal_name where item_id=@target;
SELECT item_id,is_delete from nc2_repository_position_index where item_id=@target;
SELECT item_id,is_delete from nc2_repository_ranking where item_id=@target;
SELECT item_id,is_delete from nc2_repository_suffix where item_id=@target;
SELECT item_id,is_delete from nc2_repository_supple where item_id=@target;
SELECT item_id,is_delete from nc2_repository_thumbnail where item_id=@target;








