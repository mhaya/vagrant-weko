<?php
// --------------------------------------------------------------------
//
// wekoDB2TSV.php
//
// Copyright (c) 2012 Masaharu Hayashi
//
// This program is licensed under a Creative Commons BSD Licence
// http://creativecommons.org/licenses/BSD/
//
// --------------------------------------------------------------------
ini_set('memory_limit', '512M');

$ini_array = parse_ini_file("config.ini", true);

$host=$ini_array['db']['host'];
$user=$ini_array['db']['user'];
$pass=$ini_array['db']['pass'];
$dbname=$ini_array['db']['dbname'];
$tbl_prefix=$ini_array['db']['tbl_prefix'];
$item_type_id=$ini_array['output']['item_type_id'];
//$delimiter=$ini_array['output']['delimiter'];
$delimiter="\t";
// 将来は無くしたい．
$shift=5;

// login 
$link=mysql_connect($host,$user,$pass);
if(!$link){
	die('cant connect!'.mysql_error());
}
// select database
$db_selected = mysql_select_db($dbname,$link);
if(!$db_selected){
	die('cant select!'.mysql_error());
}


$attr=getAttributesOfItemType($item_type_id,$tbl_prefix);

$rows=getRecords($item_type_id,$tbl_prefix,$shift);

mysql_close($link);

printTSV($attr,$rows,$delimiter,$shift);
exit();


function getRecords($item_type_id,$tbl_prefix,$shift){
$item_type_name=getItemTypeName($item_type_id,$tbl_prefix);
$rows=array();
$result = mysql_query('select item_id,item_no,title,title_english from '.$tbl_prefix.'_repository_item where is_delete=0 and item_type_id='.$item_type_id);
if(!$result){
	die('fail query.'.mysql_error());
}
while ($row = mysql_fetch_assoc($result)) {
  $tmp[0]=array($item_type_name);
  $tmp[1]=array($row['item_id']);
  $tmp[2]=array($row['item_no']);
  $tmp[3]=array($row['title']);
  $tmp[4]=array($row['title_english']);
  $rows[$row['item_id']]=$tmp;
}

//print_r($rows);

$result = mysql_query('select item_id,attribute_id,attribute_no,attribute_value from nc2db_repository_item_attr where item_type_id='.$item_type_id);
if(!$result){
	die('fail query.'.mysql_error());
}

while ($row = mysql_fetch_assoc($result)) {
  $tmp=$rows[$row['item_id']];
  $id=$row['attribute_id'];
  if(isset($tmp[$id+$shift])){
       $tmp2=$tmp[$id+$shift];
  }else{
       $tmp2=array();
  }
     array_push($tmp2,$row['attribute_value']);
     $tmp[$id+$shift]=$tmp2;
     if($attr[$id]['cnt']<count($tmp2)){
       $attr[$id]['cnt']=count($tmp2);
     }

  $rows[$row['item_id']]=$tmp;
}
return $rows;
}

function getAttributesOfItemType($item_type_id,$tbl_prefix){
// select attribute of item
$result = mysql_query('select item_type_id,attribute_id,attribute_name,plural_enable from '.$tbl_prefix.'_repository_item_attr_type where item_type_id='.$item_type_id);
if(!$result){
	die('fail query.'.mysql_error());
}
$attr=array();
while ($row = mysql_fetch_assoc($result)) {
  $tmp['name']=$row['attribute_name'];
  $tmp['id']=$row['attribute_id'];
  $tmp['cnt']=1;
  $attr[$row['attribute_id']]=$tmp;
}
return $attr;
}


function getItemTypeName($item_type_id,$tbl_prefix){
// get item type name
$result = mysql_query('select item_type_id,item_type_name from '.$tbl_prefix.'_repository_item_type where item_type_id='.$item_type_id);
if(!$result){
	die('fail query.'.mysql_error());
}
while ($row = mysql_fetch_assoc($result)) {
  $item_type_name = $row['item_type_name'];
}
return $item_type_name;
}

function printTSV($attr,$rows,$delimiter,$shift){
// print header part
print "item type".$delimiter;
print "item id".$delimiter;
print "item no".$delimiter;
print "title".$delimiter;
print "title_english".$delimiter;

foreach($attr as $col){
  $name=$col['name'];
  $cnt=$col['cnt'];
  for($i=0;$i<$cnt;$i++){
     print $name.$delimiter;
  }
}
print "\n";
// print data part
foreach($rows as $row){
    print $row[0][0].$delimiter.$row[1][0].$delimiter.$row[2][0].$delimiter.$row[3][0].$delimiter.$row[4][0].$delimiter; 
 foreach($attr as $col){
    $id=$col['id'];
    $cnt=$col['cnt'];
    if(isset($row[$id+$shift])){
         $dat=$row[$id+$shift];
	 for($i=0;$i<$cnt;$i++){
	   if(isset($dat[$i])){
	     print $dat[$i].$delimiter;
	   }else{
	     print " ".$delimiter;
	   }
	 }
       }else{
	 for($i=0;$i<$cnt;$i++){
	   print " ".$delimiter;
	 }
       }
  } 
 print "\n";
}
}

?>
