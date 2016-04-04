#Change default language
cat > /etc/sysconfig/i18n << EOM
LANG="en_US.UTF-8"
SYSFONT="latarcyrheb-sun16"
EOM

# Install REMI Repository 
yum install -y http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
#install php5.6 and Apache 2.2
yum install -y php php56-php-mbstring php56-php-pdo php-pgsql --enablerepo=remi,remi-php56
chkconfig httpd on
# Install Postgresql
rpm -Uvh http://yum.postgresql.org/9.4/redhat/rhel-6-x86_64/pgdg-centos94-9.4-1.noarch.rpm
yum install -y postgresql94-server postgresql94-contrib
#init DB
service postgresql-9.4 initdb
service postgresql-9.4 start
chkconfig postgresql-9.4 on