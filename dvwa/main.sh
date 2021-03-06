#!/bin/bash

echo '[+] Starting mysql...'

echo "--> Ensuring /var/lib/mysql is empty and owned by mysql user."
rm -rf /var/lib/mysql
mkdir -p /var/lib/mysql
chown -R mysql:mysql /var/lib/mysql

echo "--> Initializing MySQL..."
mysqld --initialize-insecure 

echo "--> Starting MySQL..."
service mysql start

echo "--> Creating usernames and passwords file..."
echo "--> Setting Debian user password for Mysql (in case /var/lib/mysql was mounted)"
debpass=$(cat /etc/mysql/debian.cnf | grep password | awk '{print $3}' |tail -n 1)
debpasswdcmd="GRANT ALL PRIVILEGES on *.* TO 'debian-sys-maint'@'localhost' IDENTIFIED BY '$debpass' WITH GRANT OPTION;\nFLUSH PRIVILEGES;"

echo "--> Setting dvwa accessor user for MariaDB"
dvwacmd="create database dvwa;\ngrant all on dvwa.* to 'dvwa'@'localhost' identified by 'p@ssw0rd';\nflush privileges;"

echo -e "$debpasswdcmd\n$dvwacmd" > init.sql
mysql -u root < init.sql

echo '--> Verifying mysql service...'
ss=$(service mysql status)
echo "$ss"
if [[ "$ss" == "MySQL is stopped.." ]]; then
	echo "----> Mysql is not running."
        echo "$ss"
        echo "----> Displaying last few lines of mysql service error log."
        tail /var/log/mysql/error.log
        echo "----> If the error is Can't open and lock privilege tables: Got error 140 from storage engine,"
	echo "      your docker is probably running overlay2 or overlay. Mysql only runs on aufs."
        echo "      An easy remedy is to mount an external volume at /var/lib/mysql"
	echo "      You may just mount a tmpfs: --mount type=tmpfs,destination=/var/lib/mysql"
	exit 1
else
	echo "----> Mysql is running..."
fi

echo '[+] Starting apache'
cp /var/www/html/config/config.inc.php.dist /var/www/html/config/config.inc.php
sed 's/.*$_DVWA.*root.*/$_DVWA[ '"'"'db_user'"'"' ]     = '"'"'dvwa'"'"';/' /var/www/html/config/config.inc.php > /var/www/html/config/config.inc.php.new
yes | cp /var/www/html/config/config.inc.php.new /var/www/html/config/config.inc.php

echo "Scrambling all php files to match the polyscripted version..."
/usr/local/bin/scramble.sh

echo "Restarting apache..."
service apache2 start

while true
do
    tail -f /var/log/apache2/*.log
    exit 0
done
