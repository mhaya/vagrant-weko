#WekoTools

リポジトリシステムWEKOのためのちょっとしたツールを公開します．基本的には自分の作業を効率的にするために作成したものなので，バグや癖があるかもしれません．

##WekoDB2TSV.php

WEKOに登録されたデータをTSVファイルに出力します．
出力単位はアイテムタイプ毎です．

使い方：
config.iniにデータベースの接続情報および出力するアイテムタイプ情報を設定してから，下記コマンドを実行します．
$ php WekoDB2TSV.php > hoge.tsv

##TSV2WekoDB.php

WekoDB2TSV.phpで出力したTSVファイルをWEKOに取り込みます
最新の登録内容とTSVファイルを比較し，変更された項目のみWEKOに反映させます．

*現在はUPDATEクエリを出力します．問題なさそうであればクエリ実行も含めてしまう予定です．

使い方：
config.iniにデータベースの接続情報を設定してから，下記コマンドを実行します．
$ php TSV2WekoDB.php hoge.tsv > sql.txt



