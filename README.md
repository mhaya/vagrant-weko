#WekoTools

NC2のリポジトリモジュールであるWEKO(http://weko.at.nii.ac.jp/)のためのちょっとしたツールです．自分の作業を効率的にするために作成したものなので，バグや癖があるかもしれません．

動作確認は2.0.1で行っています．

「WekoDB2TSV.php」「TSV2WekoDB.php」はWEKOに登録されたデータを一括変更することを想定したツールです．データベースを直接操作します．

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



