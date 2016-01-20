#Change default language
cat > /etc/sysconfig/i18n << EOM
LANG="en_US.UTF-8"
SYSFONT="latarcyrheb-sun16"
EOM

#install Apache
 yum install -y httpd
 chkconfig httpd on

 #install php5.5
 rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm
 yum install -y php55w php55w-opcache php55w-mbstring php55w-pdo

#install mysql 
yum install -y mysql mysql-server
service mysqld start
#reset root password
#restart mysqld in the safe mode
service mysqld stop
mysqld_safe --skip-grant-tables &
# wait until mysqld service started, re-try maximum 5 times
numloop=1
statusv=$(service mysqld status|grep running)
while [[ $numloop -lt 5 ]]; do
	#statements
	statusv=$(service mysqld status|grep running)
	if [ "$statusv" != "" ]
	then
		#statements
		break
	fi
	numloop=`expr $numloop + 1` 
	sleep 5s
done
mysql -uroot --database=mysql << EOM
update user set password=PASSWORD("test") where User='root';
flush privileges;
EOM
service mysqld restart
chkconfig  mysqld on
reboot