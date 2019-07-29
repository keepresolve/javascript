#!/bin/bash
stty erase '^H'
export MY_SHELL_PATH=$(cd "$(dirname "$0")"; pwd)
cd $MY_SHELL_PATH

date=`date +"%Y-%m-%d %H:%M:%S"`
LOG_FILENAME=RDS_CM_CR_initialize_log
touch $LOG_FILENAME

echo ""
read -p '此脚本为RDS初始化脚本,如目标RDS有相应数据库则会被删除掉，请谨慎执行！
请输入要运行的功能
1. 新RDS服务器初始化:emicall_cc_man
2. 新RDS服务器初始化:emicall_cc_running
3. 退出
: ' num

if [ $num = 1 ] || [ $num = 2 ];then
read -p '
请输入远程RDS连接主机地址
: ' local_host

read -p '
请输入远程RDS连接用户名
: ' local_user

read -p '
请输入远程RDS连接密码
: ' local_dbpwd

else
	exit 0
fi
mysql="mysql -h${local_host} -u${local_user} -p${local_dbpwd}"

ret=`$mysql -ss -e "select 1"`
if [ $? -ne 0 ];then
	echo "mysql连接失败"
	echo "$date" >> $LOG_FILENAME
	echo "mysql连接失败" >> $LOG_FILENAME
	exit 1
fi

$mysql -ss -e "set global log_bin_trust_function_creators=1" >/dev/null 2>&1

echo ""
if [ $num -eq 1 ];then
	database='emicall_cc_man'
	sql='emicall_cc_man_rds.sql'
	$mysql -ss -e "drop database if exists $database;CREATE DATABASE $database DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci"
	rm -rf ${sql}_tmp
	cp ${sql} ${sql}_tmp
	sed -i "s/\`emicall_cr_s\`@\`%\`/\`emicall_cr_s\`@\`${local_host}\`/g" ${sql}_tmp
	sed -i "s/emicall_cr_s/${local_user}/g" ${sql}_tmp
	$mysql  < ${sql}_tmp
	if [ $? -eq 0 ];then
		echo "$date $mysql 初始化 $database 完成"
		echo "$date $mysql 初始化 $database 完成" >> $LOG_FILENAME

		$mysql  < mobile_state.sql
		if [ $? -eq 0 ];then
			echo "$date $mysql 手机号段区号表mobile_state导入成功"
			echo "$date $mysql 手机号段区号表mobile_state导入成功" >> $LOG_FILENAME
		else
			echo "$date $mysql 手机号段区号表mobile_state导入失败"
			echo "$date $mysql 手机号段区号表mobile_state导入失败" >> $LOG_FILENAME
		fi
	else
		echo "$date $mysql 初始化 $database 失败"
		echo "$date $mysql 初始化 $database 失败" >> $LOG_FILENAME
	fi
	


elif [ $num -eq 2 ];then
	database='emicall_cc_running'
	sql='emicall_cc_running.sql'
	$mysql -ss -e "drop database if exists $database;CREATE DATABASE $database DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci"
	rm -rf ${sql}_tmp
	cp ${sql} ${sql}_tmp
	sed -i "s/\`emicall_cr_s\`@\`%\`/\`emicall_cr_s\`@\`${local_host}\`/g" ${sql}_tmp
	sed -i "s/emicall_cr_s/${local_user}/g" ${sql}_tmp
	$mysql  < ${sql}_tmp
	if [ $? -eq 0 ];then
		echo "$date $mysql 初始化 $database 完成"
		echo "$date $mysql 初始化 $database 完成" >> $LOG_FILENAME
	else
		echo "$date $mysql 初始化 $database 失败"
		echo "$date $mysql 初始化 $database 失败" >> $LOG_FILENAME
	fi

else
	echo "输入: $num  退出"
fi
