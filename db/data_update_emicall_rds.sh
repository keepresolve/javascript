#!/bin/bash
##夜间23点至第二天07点外时间触发暂停脚本开关(测试研发RDS(非线上)升级专用开关--0:开启,1:关闭)。设置为1白天也能升级RDS
kill_time_status=0
##

stty erase '^H'
export MY_SHELL_PATH=$(cd "$(dirname "$0")"; pwd)
cd $MY_SHELL_PATH

date1=`date +%s`
mkdir -p /opt/
LOG_FILENAME=/opt/upgrade_RDS_`date +%Y%m%d-%H%M%S`
LOG_FILENAME1=/opt/upgrade_error_RDS_`date +%Y%m%d-%H%M%S`
touch $LOG_FILENAME $LOG_FILENAME1


read -p '
请输入远程RDS连接主机地址
: ' local_host

read -p '
请输入远程RDS连接用户名
: ' local_user

read -p '
请输入远程RDS连接密码
: ' local_dbpwd


log_common()
{
  days=`date "+%Y-%m-%d %H:%M:%S"`
  echo $days $1
  echo $days $1 >> $LOG_FILENAME
}

log_error_common()
{
  days=`date "+%Y-%m-%d %H:%M:%S"`
  echo $days $1
  echo $days $1 >> $LOG_FILENAME1
}

mysql="mysql -h${local_host} -u${local_user} -p${local_dbpwd}"
mysqldump="mysqldump -h${local_host} -u${local_user} -p${local_dbpwd}"

ret=`$mysql -ss -e "select 1"`
if [ $? -ne 0 ];then
		log_error_common "mysql连接失败"
		exit 1
fi


###############################
update_field()
{
	sql_txt_order=$1
	database=$2
	sql_txt_delimiter=$3
	
	update_status=0
	$mysql -ss -e "select TRIGGER_SCHEMA,EVENT_OBJECT_TABLE,TRIGGER_NAME from information_schema.TRIGGERS where TRIGGER_SCHEMA regexp '$database'" >triggers.txt

	while read -r line
	do
		trigger_type=0
		time1=`date +%s`
		for table in `cat tables.txt`
		do
			table_sql_info=`echo $line |egrep -i "'$table'|' $table '| $table "`
			if  [ -n "$table_sql_info" ] ;then
				break
			fi
		done
		add_field_tmp=${line//PRO_DBNAME/$database}
		
		mysql_d="$mysql $database"
		
		create_delimiter_sql=`echo $line |egrep -i '^create|^DELIMITER'`
		if  [ -n "$create_delimiter_sql" ] ;then
			$mysql_d -ss -e "$add_field_tmp"
			if [ $? -ne 0 ];then
				log_error_common "$database sql执行失败!  $add_field_tmp"
				update_status=1
			else
				log_common "$database is OK ! $add_field_tmp"
				sed -i "/$add_field_tmp/d" ${sql_txt_order}
			fi
			continue
		fi
		

		if [ "$kill_time_status" -eq 0 ];then
			kill_time=`date "+%H"`
			let kill_time=10#$kill_time
			while [ $kill_time -ge 7 ] && [ $kill_time -le 22 ]
			do
				log_common "时间触发暂停脚本1小时"
				sleep 3600
				kill_time=`date "+%H"`
				let kill_time=10#$kill_time
			done
		fi
	    
	
		table_tmp="${table}_upRDS_tmp"
		table_tmp1="${table}_upRDS_tmp_${date1}"
		
		if [ "$table" == 'group' ];then table='`'$table'`'; fi;
		
		id=`$mysql_d -ss -e "desc $table"|head -1|awk -F'\t' '{print $1}'`
		PRI=`$mysql_d -ss -e "desc $table"|head -1|awk -F'\t' '{print $4}'`
		maxid=`$mysql_d -ss -e "select count(1) from $table"`
		if [ "$maxid" -lt 200000 ];then
			#$mysql_d -ss -e "alter table $table ENGINE=innodb"
			if [ $? -ne 0 ];then
				log_error_common "$database $table 无法变更为innodb引擎,请检查是否超长字符串索引!"
				update_status=1
				continue
			fi
			$mysql_d -ss -e "$add_field_tmp"
			if [ $? -ne 0 ];then
				log_error_common "$database $table sql执行失败!  $add_field_tmp"
				update_status=1
				continue
			fi    

			log_common "$database $table is OK !"
			sed -i "/$table/d" ${sql_txt_order}

			time2=`date +%s`
			time3=$(($time2-$time1))
			hour=`expr $time3 / 3600` ;  minute=`expr \( $time3 - 3600 \* $hour \) / 60` ; second=`expr \( $time3 - 3600 \* $hour - 60 \* $minute \)`
			log_common "$database $table 用时: $hour小时$minute分$second秒"
			continue
	
		elif [ "$id" != 'id' ] || [ "$PRI" != 'PRI' ];then
			log_error_common "$database $table is no id and too big to pass!"
			update_status=1
			continue
		fi
	
		$mysql_d -ss -e "desc $table_tmp" >/dev/null 2>&1
		if [ $? -ne 0 ];then
			$mysql_d -ss -e "create table $table_tmp like $table"
			$mysql_d -ss -e "alter table $table_tmp ENGINE=innodb"
			if [ $? -ne 0 ];then
				$mysql_d -ss -e "drop table if exists $table_tmp"
				log_error_common "$database $table 无法变更为innodb引擎,请检查是否超长字符串索引!" 
				update_status=1
				continue
			fi
			$mysql_d -ss -e "${add_field_tmp//$table/$table_tmp}"
			if [ $? -ne 0 ];then
				$mysql_d -ss -e "drop table if exists $table_tmp"
				log_error_common "$database $table sql执行失败!  $add_field_tmp"
				update_status=1
				continue
			fi

			fieldnum=0
			fieldnow=()
			fieldnow1=()
			fieldnew=()
			fieldold=()
			for j in `$mysql_d -ss -e "desc $table" |awk '{print $1}'`
			do
				fieldnow[$fieldnum]="\`$j\`"
				fieldnow1[$fieldnum]="new.\`$j\`"
				fieldnew[$fieldnum]="\`$j\`=new.\`$j\`"
				fieldold[$fieldnum]="\`$j\`=old.\`$j\`"
				fieldnum=$(( $fieldnum + 1 ))
			done
	
			field=`echo ${fieldnew[@]}|tr ' ' ','`
			field1=`echo ${fieldnow[@]}|tr ' ' ','`
			field2=`echo ${fieldnow1[@]}|tr ' ' ','`
			$mysql_d -ss -e "DELIMITER // 
	CREATE TRIGGER ${table}_update AFTER update ON $table FOR EACH ROW BEGIN update $table_tmp set ${field[@]} where ${fieldold[0]}; END// 
	DELIMITER ;"
			$mysql_d -ss -e "DELIMITER // 
	CREATE TRIGGER ${table}_delete AFTER DELETE ON $table FOR EACH ROW BEGIN delete from $table_tmp where ${fieldold[0]}; END// 
	DELIMITER ;"
			$mysql_d -ss -e "DELIMITER // 
	CREATE TRIGGER ${table}_insert AFTER INSERT ON $table FOR EACH ROW BEGIN insert into $table_tmp (${field1[@]}) values (${field2[@]}); END// 
	DELIMITER ;"
			maxid=`$mysql_d -ss -e "select if(max(id) is null,0,max(id)) from $table"`
			minid=1
		else
			if [ ! -f "${database}_${table}_id.txt" ];then
				log_error_common "innodb临时表存在但无上次中断信息文件,跳过此表:$database $table"
				update_status=1
				continue
			else
				while read line_history
				do
					history_database=`echo $line_history | awk '{print $1}'`
					history_table=`echo $line_history | awk '{print $2}'`
					minid=`echo $line_history | awk '{print $4}'`
					maxid=`echo $line_history | awk '{print $5}'`
				done < ${database}_${table}_id.txt
				if [ "$database" != "$history_database" ] || [ "$table" != "$history_table" ];then
					log_error_common "innodb临时表存在,上次中断信息文件存在,但库表不匹配,跳过此表:$database $table"
					update_status=1
					continue
				fi
			fi
		fi    
	
		for ((c=$minid;c<$maxid;c+=5000))
		do
			d=$(( $c + 5000 ))
			if [ "$kill_time_status" -eq 0 ];then
				kill_time=`date "+%H"`
				let kill_time=10#$kill_time
				while [ $kill_time -ge 7 ] && [ $kill_time -le 22 ]
				do
					log_common "时间触发T暂停脚本1小时" 
					sleep 3600
					kill_time=`date "+%H"`
					let kill_time=10#$kill_time
				done
			fi
		
			$mysql_d -ss -e "insert ignore into $table_tmp(${field1[@]}) select ${field1[@]} from $table where id>=$c and id<$d"
			echo $database $table $c $d $maxid >${database}_${table}_id.txt
		
		done
		if [ $? -ne 0 ];then
			log_error_common "$database $table 导出数据错误!" 
			update_status=1
			$mysql_d -ss -e "drop table if exists $table_tmp"
			$mysql_d -ss -e "drop TRIGGER if exists ${table}_update"
			$mysql_d -ss -e "drop TRIGGER if exists ${table}_delete"
			$mysql_d -ss -e "drop TRIGGER if exists ${table}_insert"
			continue
		fi
		cat triggers.txt|grep $database|grep $table >triggers_tmp.txt
		rm -rf triggers.sql
		while read line_trigger
		do
			trigger_database=`echo $line_trigger | awk '{print $1}'`
			trigger_table=`echo $line_trigger | awk '{print $2}'`
			trigger_name=`echo $line_trigger | awk '{print $3}'`
			if [ "$database" == "$trigger_database" ] && [ "$table" == "$trigger_table" ];then
				echo 'DELIMITER //' >>triggers.sql
				$mysql_d -ss -e "show create trigger $trigger_name"|awk -F'\t' '{print $3}' >>triggers.sql
				sed -i "s/\\\n/\\t/g" triggers.sql
				echo '//' >>triggers.sql
				trigger_type=1
				$mysql_d -ss -e "drop trigger if exists $trigger_name"
			fi
		done < triggers_tmp.txt
		      
		      
		$mysql_d -ss -e "alter table $table rename $table_tmp1"
		$mysql_d -ss -e "alter table $table_tmp rename $table"
		if [ "$trigger_type" -eq 1 ];then
			$mysql_d <triggers.sql  
		fi

		$mysql_d -ss -e "drop TRIGGER if exists ${table}_update"
		$mysql_d -ss -e "drop TRIGGER if exists ${table}_delete"
		$mysql_d -ss -e "drop TRIGGER if exists ${table}_insert"
		maxid=`$mysql_d -ss -e "select if(max(id) is null,0,max(id)) from $table_tmp1"`
		count1=`$mysql_d -ss -e "select count(1) from $table_tmp1"`
		count2=`$mysql_d -ss -e "select count(1) from $table where id<=$maxid"`
		if [ "$count1" -eq "$count2" ];then
			log_common "$database $table old:$count1 new:$count2  is OK !"
			$mysql_d -ss -e "drop table $table_tmp1"
			sed -i "/$table/d" ${sql_txt_order}
			time2=`date +%s`
			time3=$(($time2-$time1))
			hour=`expr $time3 / 3600` ;  minute=`expr \( $time3 - 3600 \* $hour \) / 60` ; second=`expr \( $time3 - 3600 \* $hour - 60 \* $minute \)`
			log_common "$database $table 用时: $hour小时$minute分$second秒" 
		else
			log_error_common "$database $table old:$count1 new:$count2  is WRONG !"
			update_status=1
		fi
		
	done < ${sql_txt_order}

	##添加存储过程
	if [ -f "$sql_txt_delimiter" ];then
		$mysql $database < $sql_txt_delimiter
		if [ $? -ne 0 ]; then
			log_error_common "$database 存储过程创建失败！"
			update_status=1
		else
			log_common "$database 存储过程更新完成！"
		fi
	fi
	
}
###############################

update_pbx()
{
  pbx_file=$3
  if [ ! -f "$pbx_file" ];then
    $mysql -ss -e "show databases" |grep $5 >$pbx_file
  fi


  #找升级结节位置
  cat $1|sed s'/ //g'|grep "^\/\*"|awk -F "*" '{print $2}'|grep '^[0-9]*$' >serial.txt
  sed -i s'/ //g' serial.txt
  for serialnum in $(<serial.txt)
  do
  {
      if [[ "$2" -ge "$serialnum" ]]
          then
          dbversion=$serialnum
      fi
  }
  done
  echo $dbversion

  #找到升级节点后的执行sql
  cat $1 |grep -A 1000000 "/\*${dbversion}"| grep -v "/\*${dbversion}"|grep -v "^\/\*" |grep -v ^'#'|sed '/^$/d'|sed '/^ *$/d'|sed '/^\t*$/d'|sed '/^\t*#/d'|sed '/^ *#/d' > $4
  
  rm -rf ${4}_delimiter
  delimiter_status=0
  while read -r line
  do
  	delimiter_sql_start=`echo $line |grep -i "^delimiter"|grep '/'`
	
		delimiter_sql_sipk1=`echo $line |grep -i "^delimiter"|grep '/'`
		delimiter_sql_sipk2=`echo $line |grep -i "^delimiter"|grep ';'`
		delimiter_sql_sipk3=`echo $line |grep -i "end"|grep ';'|grep '/'`
		delimiter_sql_sipk4=`echo $line |grep '/'`
	
  	if  [ -n "$delimiter_sql_start" ] ;then delimiter_status=1; fi;
  	if [ "$delimiter_status" -eq 1 ];then 
			echo $line >>${4}_delimiter
			if  [ ! -n "$delimiter_sql_sipk1" ] && [ ! -n "$delimiter_sql_sipk2" ] && [ ! -n "$delimiter_sql_sipk3" ] && [ ! -n "$delimiter_sql_sipk4" ];then
				sed -i "/$line/d" $4
				delimiter_sql_sipk0=`echo $line |grep '*'`
				if  [ -n "$delimiter_sql_sipk0" ];then sed -i "/${line//\*/\\*}/d" $4; fi
			fi
		fi
  	delimiter_sql_stop=`echo $line |grep -i "^delimiter"|grep ';'`
  	if  [ -n "$delimiter_sql_stop" ] ;then delimiter_status=0; fi;
  done < $4
  sed -i "/delimiter/d" $4
  sed -i "/DELIMITER/d" $4
  sed -i "/end.*;.*\//d" $4
  sed -i "/END.*;.*\//d" $4
  sed -i "/\//d" $4
  
	#升级节点后的执行sql按表排序
	if [ ! -f "${4}_order" ];then
		rm -rf ${4}_order
		sql_num1=`cat $4 |wc -l`
		sql_num=0
		$mysql $name1 -ss -e "show tables" |sort -r >tables.txt
		for table in `cat tables.txt`
		do
			table_sql_info_tmp=''
			while read -r line
			do
				table_sql_info=`echo $line |egrep -i "'$table'|' $table '| $table "`
				if  [ -n "$table_sql_info" ] ;then
					sql_num=$(( $sql_num + 1 ))
					table_sql_info_tmp=${table_sql_info_tmp}${table_sql_info}
				fi
			done < $4
			if  [ "$table_sql_info_tmp" != '' ] ;then
				echo $table_sql_info_tmp >>${4}_order
			fi
		done
		
		table_sql_info_tmp=''
		while read -r line
		do
			table_sql_info=`echo $line |egrep -i '^create'`
			if  [ -n "$table_sql_info" ] ;then
				sql_num_table=`echo $line |awk '{print $6}'`
				if [ "$sql_num_table" == 'group' ];then sql_num_table='`'$sql_num_table'`'; fi;
				$mysql $name1 -ss -e "desc $sql_num_table" >/dev/null 2>&1
				if [ $? -ne 0 ];then
					sql_num=$(( $sql_num + 1 ))
					table_sql_info_tmp=${table_sql_info_tmp}${table_sql_info}
				fi
			fi
		done < $4
		if  [ "$table_sql_info_tmp" != '' ] ;then
			echo $table_sql_info_tmp >>${4}_order
		fi
	else
		sql_num1=`cat $4 |wc -l`
		sql_num=`cat $4 |wc -l`
		$mysql $name1 -ss -e "show tables" |sort -r >tables.txt
	fi
	
	if [ "$sql_num1" -eq "$sql_num" ];then
	  for i in `cat $pbx_file`
	  do
	    mkdir -p /etc/update_mysql/$5/$i
	    $mysqldump -R -E -d $i >/etc/update_mysql/$5/$i/${i}_tmp.sql
	    $mysql -ss -e "CREATE DATABASE ${i}_tmp DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci"
	    $mysql ${i}_tmp < /etc/update_mysql/$5/$i/${i}_tmp.sql
	    cat ${4}_order > tmp_${i}_${4}
	    if [ "$5" = "pbx_0" ] || [ "$5" = "svc_0" ];then
	        sed -i "s/PRO_DBNAME/${i}/g" tmp_${i}_${4}
	    fi
	    cat tmp_${i}_${4} > tmp_${i}_${4}_newdatabase
	    if [ "$5" = "talk" ];then
	        sed -i "s/${i}\./${i}_tmp\./g" tmp_${i}_${4}_newdatabase
	        sed -i "s/'${i}'/'${i}_tmp'/g" tmp_${i}_${4}_newdatabase
	    else
	        sed -i "s/${i}/${i}_tmp/g" tmp_${i}_${4}_newdatabase
	    fi
	    $mysql ${i}_tmp < tmp_${i}_${4}_newdatabase
	    if [ $? -ne 0 ]; then
	      log_error_common "$i 模拟升级失败！"
	      echo "$i 模拟升级失败！" >>$LOG_FILENAME
	      $mysql -ss -e "drop database ${i}_tmp"
	      rm -rf tmp_${i}_${4}_newdatabase
	      rm -rf tmp_${i}_${4}
	      sleep 3
	      continue
	    fi
	    if [ -f "${4}_delimiter" ];then
	    	cp ${4}_delimiter tmp_${4}_delimiter_newdatabase
	    	sed -i "s/${i}/${i}_tmp/g" tmp_${4}_delimiter_newdatabase
	      $mysql ${i}_tmp < tmp_${4}_delimiter_newdatabase
	      if [ $? -ne 0 ]; then
	        log_error_common "$i 模拟升级失败--存储过程！"
	        echo "$i 模拟升级失败--存储过程！" >>$LOG_FILENAME
	        $mysql -ss -e "drop database ${i}_tmp"
	        rm -rf tmp_${4}_delimiter_newdatabase
	        rm -rf ${4}_delimiter
	        sleep 3
	        continue
	      else
	      	rm -rf tmp_${4}_delimiter_newdatabase
	      fi
	    fi
	    $mysql -ss -e "drop database ${i}_tmp"
	    rm -rf tmp_${i}_${4}_newdatabase
	    update_field "${4}_order" "${i}" "${4}_delimiter"
	    if [ "$update_status" -ne 0 ]; then
	      log_error_common "$i sql升级失败！" 
	      echo "$i sql升级失败！" >>$LOG_FILENAME
	      rm -rf tmp_${i}_${4}
	    else
	      log_common "$i 升级完成" 
	      $mysql $i -ss -e "$6"
	      rm -rf tmp_${i}_${4}
	      sed -i "/$i/d" $pbx_file
	      sleepnum=`expr $RANDOM % 20`
	      sleep $sleepnum
	      sed -i "/$i/d" $pbx_file
	    fi
	    sleep 3
	  done
	  log_common "所有库循环完成"
	else
		log_error_common "升级节点后的执行sql按表排序失败: $4 排序前:${sql_num1} 排序后:${sql_num}"
		mv ${4}_order ${4}_order.bak
	fi
}




#!!!!!upgrade begin!!!!!

#check upgrade user whether www-data
user_who=`whoami`

if [ "$user_who" == "root" ]; then
	echo "yes,you can upgrade" >>$LOG_FILENAME
else
	echo "sorry,you are not root,error!"
	echo "sorry,you are not root,error!" >>$LOG_FILENAME1
	exit 1
fi


if [ "$kill_time_status" -eq 0 ];then
	kill_time=`date "+%H"`
	let kill_time=10#$kill_time
	while [ $kill_time -ge 7 ] && [ $kill_time -le 22 ]
	do
		log_common "时间触发暂停脚本1小时"
		sleep 3600
		kill_time=`date "+%H"`
		let kill_time=10#$kill_time
	done
fi


#######################################
#######################################
#####cc_man升级
#升级文件
update_pbx_file='update_emicall_cc_man_rds.sql'
#升级库文件
table_file='cc_man_rds_file.txt'
#升级节点后的执行sql文件名
sql_pbx_table='sql_cc_man_rds.sql'
#涉及升级数据库
name1='emicall_cc_man'

$mysql -ss -e "use $name1" >/dev/null 2>&1
if [ $? -eq 0 ];then
	log_common "RDS: ${local_host}   DB: ${name1} 开始升级"
	echo "开始比对cc_man版本节点"
	old_pbx_ver=`$mysql $name1 -ss -e 'select value from setting where \`key\`="cc_man_db_version"'`
	
	#####
	if [ "$old_pbx_ver" -eq 4387 ];then old_pbx_ver=3578; fi;
	#####
	
	#判断升级文件是否存在
	if [ ! -f "$update_pbx_file" ];then
		log_error_common "${name1}升级文件不存在,跳过${name1}库升级!"
	else
		#找new_pbx_ver结节位置
		new_pbx_ver=0
		for serialnum in `cat $update_pbx_file |sed s'/ //g'|grep "^\/\*"|awk -F "*" '{print $2}'|grep '^[0-9]*$'`
		do
			if [[ "$new_pbx_ver" -lt "$serialnum" ]];then
				new_pbx_ver=$serialnum
			fi
		done
		update_new_pbx_ver='INSERT INTO `setting` (`key`, `value`, `description`) VALUES ('"'cc_man_db_version'"', '"'$new_pbx_ver'"', '"'数据库版本'"') ON DUPLICATE KEY UPDATE `value`=VALUES(`value`)'
	
		if [ "$old_pbx_ver" -lt "$new_pbx_ver" ];then
			log_common "比对版本节点完成,新版本:$new_pbx_ver  现在版本:$old_pbx_ver"
			log_common "${name1}库升级开始"
			update_pbx "$update_pbx_file" "$old_pbx_ver" "$table_file" "$sql_pbx_table" "$name1" "$update_new_pbx_ver"
		else
			log_error_common "版本错误 : 新版本:$new_pbx_ver  现在版本:$old_pbx_ver"
			log_error_common "跳过${name1}库升级!"
		fi
	fi
fi

new_pbx_ver=''
old_pbx_ver=''


#######################################
#####cc_running升级
#升级文件
update_pbx_file='update_emicall_cc_running.sql'
#升级库文件
table_file='cc_running_rds_file.txt'
#升级节点后的执行sql文件名
sql_pbx_table='sql_cc_running_rds.sql'
#涉及升级数据库
name1='emicall_cc_running'

$mysql -ss -e "use $name1" >/dev/null 2>&1
if [ $? -eq 0 ];then
	log_common "RDS: ${local_host}   DB: ${name1} 开始升级"
	echo "开始比对cc_running版本节点"
	old_pbx_ver=`$mysql $name1 -ss -e 'select config_value from cc_talk_config where config_key="cc_running_db_version"'`

	#####
	if [ "$old_pbx_ver" -eq 4384 ];then old_pbx_ver=3491; fi;
	#####

	#判断升级文件是否存在
	if [ ! -f "$update_pbx_file" ];then
		log_error_common "${name1}升级文件不存在,跳过${name1}库升级!"
	else
		#找new_pbx_ver结节位置
		new_pbx_ver=0
		for serialnum in `cat $update_pbx_file |sed s'/ //g'|grep "^\/\*"|awk -F "*" '{print $2}'|grep '^[0-9]*$'`
		do
			if [[ "$new_pbx_ver" -lt "$serialnum" ]];then
				new_pbx_ver=$serialnum
			fi
		done
		update_new_pbx_ver='INSERT INTO `cc_talk_config` (`config_key`, `config_value`, `description`) VALUES ('"'cc_running_db_version'"', '"'$new_pbx_ver'"', '"'数据库版本'"') ON DUPLICATE KEY UPDATE `config_value`=VALUES(`config_value`)'
	
		if [ "$old_pbx_ver" -lt "$new_pbx_ver" ];then
			log_common "比对版本节点完成,新版本:$new_pbx_ver  现在版本:$old_pbx_ver"
			log_common "${name1}库升级开始"
			update_pbx "$update_pbx_file" "$old_pbx_ver" "$table_file" "$sql_pbx_table" "$name1" "$update_new_pbx_ver"
		else
			log_error_common "版本错误 : 新版本:$new_pbx_ver  现在版本:$old_pbx_ver"
			log_error_common "跳过${name1}库升级!"
		fi
	fi
fi
new_pbx_ver=''
old_pbx_ver=''





