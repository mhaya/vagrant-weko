<?php
// --------------------------------------------------------------------
//
// TSV2WekoDB.php
//
// Copyright (c) 2012 Masaharu Hayashi
//
// This program is licensed under a Creative Commons BSD Licence
// http://creativecommons.org/licenses/BSD/
//
// --------------------------------------------------------------------

$ini_array = parse_ini_file("config.ini", true);

$host=$ini_array['db']['host'];
$user=$ini_array['db']['user'];
$pass=$ini_array['db']['pass'];
$dbname=$ini_array['db']['dbname'];
$tbl_prefix=$ini_array['db']['tbl_prefix'];
$item_type_id=$ini_array['output']['item_type_id'];
$delimiter="\t";

$path="";
if($argc==2){
    $path=$argv[1];
}else{
    print("Usage: ".$argv[0]." tsvfile \n");
    exit();
}
readCSV($path,"\t",$record,$header);

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

getAttribute($attr,$header,$tbl_prefix,$item_type_id);

generateQuery($attr,$record,$tbl_prefix,$item_type_id);

mysql_close($link);

function generateQuery($attr,$record,$tbl_prefix,$item_type_id){
    foreach($record as $row){
        // magic number
        $item_type_name=$row[0];
        $item_id=$row[1];
        $item_no=$row[2];
        $item_title=$row[3];
        $item_title_english=$row[4];

        $shift=5;

        $sql="select attribute_id,attribute_no,attribute_value from ".$tbl_prefix."_repository_item_attr where item_id=".$item_id;

        $result2 =mysql_query($sql);
        if(!$result2){
            die('fail query.'.mysql_error());
        }
        
        // get old value
        $old=array();
        while ($row2 = mysql_fetch_assoc($result2)) {
            $id=$row2['attribute_id'];
            $no=$row2['attribute_no'];
            $val=$row2['attribute_value'];
            $old[$id][$no]=$val;
        }

        $attr_no=array();
        for($i=$shift;$i<count($row);$i++){
            if($attr[$i]!=-1){
                $attribute_id=$attr[$i];
                if(isset($attr_no[$attribute_id])){
                    $tmp = $attr_no[$attribute_id];
                    $tmp++;
                    $attr_no[$attribute_id]=$tmp;
                }else{
                    $attr_no[$attribute_id]=1;
                }
                //$sql="select attribute_value from ".$tbl_prefix."_repository_item_attr where item_id=".$item_id." and attribute_id=".$attribute_id." and attribute_no=".$attr_no[$attribute_id];
                
                //print $attr_no[$attribute_id]."\n";
                //print $old[$attribute_id][$attr_no[$attribute_id]]."=".$row[$i]."\n";
             
               if(isset($old[$attribute_id][$attr_no[$attribute_id]]) ){       
                   if((strlen(trim($row[$i]))>0) && 
                       ($row[$i]!=$old[$attribute_id][$attr_no[$attribute_id]])){
                           $sql="update ".$tbl_prefix."_repository_item_attr set attribute_value='".$row[$i]."' where item_id=".$item_id." and attribute_id=".$attribute_id." and attribute_no=".$attr_no[$attribute_id].";";
                           print $sql."\n";
                    }
                }
            }
            
        }
    }
}
function getAttribute(&$attr,$header,$tbl_prefix,$item_type_id){
    $attr=array();
    for($i=0;$i<count($header);$i++){
        $col=$header[$i];
        $sql= 'select attribute_id,attribute_name from '.$tbl_prefix.'_repository_item_attr_type where item_type_id='.$item_type_id.' and attribute_name="'.$col.'"';
        //print $sql."\n";
        $result =mysql_query($sql);
        if(!$result){
            die('fail query.'.mysql_error());
        }
        
        if (mysql_num_rows($result) == 0) {
            array_push($attr,-1);
        }else{

        while ($row = mysql_fetch_assoc($result)) {
            array_push($attr,$row['attribute_id']);
        }

        }
    
    }
    return TRUE;
}

function readCSV($path,$sep,&$record,&$header){
    $row = 1;
    if (($handle = fopen($path, "r")) !== FALSE) {
        while (($data = fgetcsv($handle, 0, $sep)) !== FALSE) {
            $num = count($data);
            if($row==1){
                $header=$data;
            }else{
                $record[]=$data;
            }
            $row++;
            }
        fclose($handle);
    }
    return TRUE;
}
?>