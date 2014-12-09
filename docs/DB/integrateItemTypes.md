# 2つのアイテムタイプを統合する

手順:

1. [mysqlにログインする](#sec0)
2. [統合するアイテムタイプの item_type_id を確認する](#sec1)
3. [2つのアイテムタイプの差異を確認する](#sec2)
4. [アイテムタイプを統合する](#sec3)
5. [統合結果を確認する](#sec4)

## mysqlにログインする<a name="sec0"/>

サーバにログインする。

    ssh test

mysql に root でログインし、データベースに接続する。

    scl enable mysql55 'mysql -u root nc2'


##統合するアイテムタイプの item_type_id を確認する<a name="sec1"/>

mysqlでの作業: 

ユーザ変数「@prefix」に NetCommons2 のテーブルプレフィックスを設定する。

    SET @prefix="nc2";

下記クエリを実行し、統合するアイテムタイプの item_type_id を確認する。

    SET @s = CONCAT('SELECT  item_type_id,item_type_name FROM ',@prefix,'_repository_item_type WHERE item_type_id < 10000');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
 

##2つのアイテムタイプの差異を確認する<a name="sec2"/>

2つのアイテムタイプの定義レコードをCSV形式で書きだす。

mysqlでの作業:

    SET @prefix="nc2";
	SET @targetA="1";
	SET @targetB="2";
	
    SET @s = CONCAT('SELECT attribute_id,show_order,attribute_name,attribute_short_name,input_type,is_required,plural_enable,line_feed_enable,list_view_enable,hidden FROM ',@prefix,'_repository_item_attr_type WHERE item_type_id = ',@targetA,' INTO OUTFILE "/tmp/exportA.csv" FIELDS TERMINATED BY \',\';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;

    SET @s = CONCAT('SELECT attribute_id,show_order,attribute_name,attribute_short_name,input_type,is_required,plural_enable,line_feed_enable,list_view_enable,hidden FROM ',@prefix,'_repository_item_attr_type WHERE item_type_id = ',@targetB,' INTO OUTFILE "/tmp/exportB.csv" FIELDS TERMINATED BY \',\';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;

一旦、mysqlからログアウトする。

サーバ側での作業：

レコード数が同じであることを確認する。異なる場合は統合に注意を要するため統合作業を中断する。

    wc /tmp/exportA.csv | awk '{print $1}'
    wc /tmp/exportB.csv | awk '{print $1}'

diffコマンドで2つのアイテムタイプの差異を確認する。

    diff -u /tmp/exportA.csv /tmp/exportB.csv 

差異が見つからない場合はそのまま[統合作業](#sec3)に移る。

差異が見つかった場合は以下の詳細を調べる。

1. [show_order の差異を調べる](#sec2-1)
2. [attribute_name,attribute_short_name の差異を調べる](#sec2-2)
3. [input_type の差異を調べる](#sec2-3)
4. [is_required,plural_enable の差異を調べる](#sec2-4)
5. [line_feed_enable,list_view_enable,hidden の差異を調べる](#sec2-5)

「1」および「5」以外で差異が見つかった場合は、統合作業に注意が必要なため作業を中断する。

すべての調査が完了したら、CSVファイルを削除する。
    
    # rm /tmp/exportA.csv
    # rm /tmp/A.csv
    # rm /tmp/exportB.csv
    # rm /tmp/B.csv
    
###1.show_order の差異を調べる<a name="sec2-1"/>

    awk -F',' '{print $1,$2}' /tmp/exportA.csv > /tmp/A.csv
    awk -F',' '{print $1,$2}' /tmp/exportB.csv > /tmp/B.csv
	diff -u /tmp/A.csv /tmp/B.csv

###2.attribute_name,attribute_short_name の差異を調べる<a name="sec2-2"/>

    awk -F',' '{print $1,$3,$4}' /tmp/exportA.csv > /tmp/A.csv
    awk -F',' '{print $1,$3,$4}' /tmp/exportB.csv > /tmp/B.csv
	diff -u /tmp/A.csv /tmp/B.csv

###3.input_type の差異を調べる<a name="sec2-3"/>

    awk -F',' '{print $1,$5}' /tmp/exportA.csv > /tmp/A.csv
    awk -F',' '{print $1,$5}' /tmp/exportB.csv > /tmp/B.csv
    diff -u /tmp/A.csv /tmp/B.csv


###4.is_required,plural_enable の差異を調べる<a name="sec2-4"/>

    awk -F',' '{print $1,$6,$7}' /tmp/exportA.csv > /tmp/A.csv
    awk -F',' '{print $1,$6,$7}' /tmp/exportA.csv > /tmp/A.csv
	diff -u /tmp/A.csv /tmp/B.csv

###5.line_feed_enable,list_view_enable,hidden の差異を調べる<a name="sec2-5"/>

    awk -F',' '{print $1$8,$9,$10}' /tmp/exportA.csv > /tmp/A.csv
    awk -F',' '{print ,$8,$9,$10}' /tmp/exportA.csv > /tmp/A.csv
	diff -u /tmp/A.csv /tmp/B.csv

##アイテムタイプを統合する<a name="sec3" />

以下のクエリを実行する。@targetA は統合後の item_type_id , @targetB は統合前の item_type_id である。
    
    SET @prefix="nc2";
	SET @targetA="1";
	SET @targetB="2";
	
    SET @s = CONCAT('UPDATE ',@prefix,'_repository_item SET item_type_id = ',@targetA,' WHERE item_type_id = ',@targetB,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    
    SET @s = CONCAT('UPDATE ',@prefix,'_repository_item_attr SET item_type_id = ',@targetA,' WHERE item_type_id = ',@targetB,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    
    SET @s = CONCAT('UPDATE ',@prefix,'_repository_search_sort SET item_type_id = ',@targetA,' WHERE item_type_id = ',@targetB,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    
    SET @s = CONCAT('UPDATE ',@prefix,'_repository_personal_name SET item_type_id = ',@targetA,' WHERE item_type_id = ',@targetB,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
   
    SET @s = CONCAT('UPDATE ',@prefix,'_repository_biblio_info SET item_type_id = ',@targetA,' WHERE item_type_id = ',@targetB,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
   
    SET @s = CONCAT('UPDATE ',@prefix,'_repository_file SET item_type_id = ',@targetA,' WHERE item_type_id = ',@targetB,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
   
    SET @s = CONCAT('UPDATE ',@prefix,'_repository_item_attr_candidate SET item_type_id = ',@targetA,' WHERE item_type_id = ',@targetB,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
   
    SET @s = CONCAT('UPDATE ',@prefix,'_repository_supple SET item_type_id = ',@targetA,' WHERE item_type_id = ',@targetB,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
   
    SET @s = CONCAT('UPDATE ',@prefix,'_repository_thumbnail SET item_type_id = ',@targetA,' WHERE item_type_id = ',@targetB,';');
    PREPARE stmt FROM @s;
    EXECUTE stmt;
   
##統合結果を確認する<a name="sec4"/>
   
[http://localhost/nc2/](http://localhost/nc2/)

WEKOにアクセスし、アイテムタイプが統合されていることを確認する。

統合後、問題が発生しないようであれば、統合元の[アイテムタイプを削除](./deleteItemType.md)する。

[TOPに戻る](../../)

---
create:20141209 ,last update:20141209

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="クリエイティブ・コモンズ・ライセンス" style="border-width:0" src="http://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br /><span xmlns:cc="http://creativecommons.org/ns#" property="cc:attributionName">Masaharu Hayashi</span> を著作者とするこの 作品 は <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">クリエイティブ・コモンズの 表示 4.0 国際 ライセンス</a>で提供されています
