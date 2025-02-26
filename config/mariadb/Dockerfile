# Using Alpine for it's minimal OS
FROM alpine

# Install MariaDB and client
RUN	apk add --no-cache mariadb mariadb-client

# Set up and run the MySQL database
ENTRYPOINT	\
if [ ! -d "/run/mysqld" ]; then \
		mkdir -p /run/mysqld \
	&&	chown -R mysql:mysql /run/mysqld \
;fi \
&& \
if [ ! -d "/var/lib/mysql/mysql" ]; then \
		chown -R mysql:mysql /var/lib/mysql \
	&&	mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --user=mysql --rpm \
	&&	TMP=/tmp/.tmpfile \
	&&	echo "USE mysql;" > ${TMP} \
	&&	echo "FLUSH PRIVILEGES;" >> ${TMP} \
	&&	echo "DELETE FROM mysql.user WHERE User='';" >> ${TMP} \
	&&	echo "DROP DATABASE IF EXISTS test;" >> ${TMP} \
	&&	echo "DELETE FROM mysql.db WHERE Db='test';" >> ${TMP} \
	&&	echo "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');" >> ${TMP} \
	&&	echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '${mysql_root_password}';" >> ${TMP} \
	&&	echo "CREATE DATABASE wordpress_database;" >> ${TMP} \
	&&	echo "CREATE USER '${mysql_admin}'@'%' IDENTIFIED BY '${mysql_admin_password}';" >> ${TMP} \
	&&	echo "GRANT ALL PRIVILEGES ON wordpress_database.* TO '${mysql_admin}'@'%' IDENTIFIED BY '${mysql_admin_password}';" >> ${TMP} \
	&&	echo "FLUSH PRIVILEGES;" >> ${TMP} \
	&&	/usr/bin/mysqld --user=mysql --bootstrap < ${TMP} \
	&&	rm -fr ${TMP} \
;fi \
&&	sed -i "s|skip-networking|# skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf \
&&	sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf \
&&	exec /usr/bin/mysqld --user=mysql --console
