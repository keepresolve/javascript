ERROR_LOG=log/error/mysql_`date +%Y%m%d-%H%M%S` 
INFO_LOG=log/info/mysql_`date +%Y%m%d-%H%M%S` 
log_error_common()
{
  days=`date "+%Y-%m-%d %H:%M:%S"`
  echo $days $1
  echo $days $1 >> $ERROR_LOG
}

read -p '
请输入远程RDS连接主机地址
: ' local_host

read -p '
请输入远程RDS连接用户名
: ' local_user

read -p '
请输入远程RDS连接密码
: ' local_dbpwd
 
echo  `主机地址:${local_host}  连接用户名:${local_user} 连接密码:${local_dbpwd}` 
mysql="mysql -h${local_host} -u${local_user} -p${local_dbpwd}"

ret=`$mysql -ss -e "select 1"`
if [ $? -ne 0 ];then
		log_error_common "mysql连接失败"
		exit 1
fi