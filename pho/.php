<?php
header("content-Type: text/html; charset=gb2312");
error_reporting(0);
ini_set('display_errors',0) ;
set_time_limit(0);
date_default_timezone_set("PRC");
$infotime=date('YmdHis');
 
//函数开始————————
//列出所有文件
function get_all_files($path){
    $list = array();
    foreach( glob( $path . '/*') as $item ){
        if( is_dir( $item ) ){
         $list = array_merge( $list , get_all_files( $item ) );
        }
        else{
         if(eregi(".jpg",$item)||eregi(".gif",$item)){
             $list[] = $item;
             }//这里可以增加判断文件名或其他。changed by:edlongren
         //$list[] = $item;
        }
    }
    return $list;
}
 
function openImageFile($file_name){   
    list($width, $height, $type, $attr) = getimagesize($file_name);   
    switch ($type){   
            case 1 :   
            $ext = "gif";   
            break;   
        case 2 :   
            $ext = "jpeg";   
            break;   
        case 3 :   
            $ext = "png";   
            break;   
    }
    $image_handle='imagecreatefrom'.$ext;
    $image_handle=$image_handle($file_name); 
    return array('image_handle'=>$image_handle,'width'=>$width,'height'=>$height);   
}   
function testSkin($image_handle,$width,$height){   
    $skin_pix = 0;   
    for($w=0;$w<$width;$w++){   
        for ($h=0;$h<$height;$h++){   
            //验证图片   
            $rgb = imagecolorat($image_handle,$w,$h);   
            $r = ($rgb >> 16) & 0xFF;   
            $g = ($rgb >> 8) & 0xFF;   
            $b = $rgb & 0xFF;   
            $Y=0.299*$r+0.587*$g+0.114*$b;   
            $Cb=0.564*($b-$Y)+128;   
            $Cr=0.713*($r-$Y)+128;   
            if($Cb >= 86 && $Cb <= 117 && $Cr >= 140 && $Cr <= 168){   
                $skin_pix ++;   
            }   
        }   
    }   
    $skin_rate =  $skin_pix/($width*$height);   
    return $skin_rate;   
}
//函数结束————————
    //echo $list;
    //echo $path;
if (isset($_GET['act'])){
    $do=isset($_GET['do'])?$_GET['do']:'f';
    $path=!empty($_GET['mulu'])?trim($_GET['mulu']):'.';
    $list=!empty($_GET['list'])?nl2br($_GET['list']):'';
if(($path||!empty($list))&&$do=='f'){   //读取要检查的对象
    if (!empty($list)){
    $img_list=explode('<br />',$list);//统计页面总数
    if (count($img_list)==0) $img_list[]=$list;
    }else{
$img_list=get_all_files($path);
    }
    $img_list=array_unique($img_list);
$count=count($img_list);
if ($count>0){
    //写入检查文件列表
$f_w="array(";
    foreach ($img_list as $e_img){
    $f_w.="'".$e_img."', \n";   
    }
$f_w=rtrim($f_w,",").")";
    $user_now_list="<?php \n";
    $user_now_list.="\$f_list=".$f_w." \n";
    $user_now_list.="?>";
        $fp = @fopen('temp/'.$infotime.'_temp.php', "w"); 
fwrite($fp,$user_now_list); 
fclose($fp);
 
die ("1|1,当前搜索目录为: <font class=red>".$path."</font><br/>共搜索到 <font class=red>".$count."</font> 张图片，开始检测……<br/>|".$infotime."|".$count."|0|0|初始化完毕！|0|0");
    }else{
die ("0|<p>当前搜索目录为: <font class=red>".$path."</font></p><p>共搜索到 <font class=red>0</font> 张图片</p>");
    }
}
  if ($do=='c'){//检查图片
      $f_name=$_GET['f'];
     $f_total=intval($_GET['total']);
     $f_now=intval($_GET['now']);
     $err=intval($_GET['err']);
include "temp/{$f_name}_temp.php";
    $file_name =$f_list[$f_now];
    $f_now+=1;
    $go=($f_total==$f_now)?1:0;
    if(is_file($file_name)){
        //文件存在  
        $image = openImageFile($file_name);   
        $rate = testSkin($image['image_handle'],$image['width'],$image['height']);   
        if($rate > 0.3){
            $err+=1;
die("1|1,<font class=red>警告：<a href=\"$file_name\" target=\"_blank\">".$file_name."</a> 特征明显！肤色比例:".$rate." </font><br/>|".$f_name."|".$f_total."|".$f_now."|".$err."|正在扫描：".$file_name."|".($f_now/$f_total)."|".$go);       
        }else {   
die("1|0,0|".$f_name."|".$f_total."|".$f_now."|".$err."|正在扫描：".$file_name."|".($f_now/$f_total)."|".$go);
        }   
    }else {   
die("1|1,系统找不到 ".$file_name." 文件! <br/>|".$f_name."|".$f_total."|".$f_now."|".$err."|正在扫描：".$file_name."|".($f_now/$f_total)."|".$go);
    }
  }
if ($do=='d'){//扫尾工作，删除临时文件
    $f_name=$_GET['f'];
     $err=intval($_GET['err']);
    if (unlink("temp/{$f_name}_temp.php")){
    die("扫描完成！|<p>共找到 <font class=red>".$err."</font> 个可疑文件</p>");
    }else{
        die("扫描完成！|共找到 <font class=red>".$err."</font> 个可疑文件<br/><p>临时文件<font class=red> ".$f_name."</font> 删除失败，请手动删除！</p>");    
    }
  }
   
}
?> 