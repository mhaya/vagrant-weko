<?php
ini_set('memory_limit', '512M');

$host='';
$user='';
$pass='';
$dbname='';
$tbl_prefix='';
$item_type_id=1;

if($argc==7){
	$host=$argv[1];
$user=$argv[2];
$pass=$argv[3];
$dbname=$argv[4];
$tbl_prefix=$argv[5];
$item_type_id=$argv[6];
}else{
print "usage: ".$argv[0]." [host] [user] [pass] [dbname] [tbl_prefix] [item_type_id]\n";
exit();
}

$item_type_name='';

$sep="\t";


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

// get item type name
$result = mysql_query('select item_type_id,item_type_name from '.$tbl_prefix.'_repository_item_type where item_type_id='.$item_type_id);
if(!$result){
	die('fail query.'.mysql_error());
}
while ($row = mysql_fetch_assoc($result)) {
  $item_type_name = $row['item_type_name'];
}

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

//print_r($attr);

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
$shift=5;
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

mysql_close($link);

//print_r($rows);

// print header part
print "item type".$sep;
print "item id".$sep;
print "item no".$sep;
print "title".$sep;
print "title_english".$sep;

foreach($attr as $col){
  $name=$col['name'];
  $cnt=$col['cnt'];
  for($i=0;$i<$cnt;$i++){
     print $name.$sep;
  }
}
print "\n";

// print data part
foreach($rows as $row){
  print $row[0][0].$sep.$row[1][0].$sep.$row[2][0].$sep.$row[3][0].$sep.$row[4][0].$sep; 
 foreach($attr as $col){
    $id=$col['id'];
    $cnt=$col['cnt'];
    if(isset($row[$id+$shift])){
         $dat=$row[$id+$shift];
	 for($i=0;$i<$cnt;$i++){
	   if(isset($dat[$i])){
	     print $dat[$i].$sep;
	   }else{
	     print " ".$sep;
	   }
	 }
       }else{
	 for($i=0;$i<$cnt;$i++){
	   print " ".$sep;
	 }
       }
  } 
 print "\n";
}
exit();
?>
