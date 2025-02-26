# Using Alpine for it's minimal OS
FROM alpine

# Set working directory
WORKDIR /var/www/html

# Install fetching tools, FastCGI process manager, WordPress command line interface and packages needed for WordPress
RUN	apk add --no-cache curl php php-phar php-openssl php-mysqli php-iconv php-fpm mariadb-client \
&&	curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o /usr/local/bin/wp \
&&	chmod +x /usr/local/bin/wp \
&&	echo "memory_limit=4096M" > /etc/php$(php -r 'echo PHP_MAJOR_VERSION.PHP_MINOR_VERSION;')/conf.d/memory.ini \
&&	wp core download --allow-root \
&&	sed -i 's|listen = 127.0.0.1:9000|listen = 0.0.0.0:9000|g' /etc/php$(php -r 'echo PHP_MAJOR_VERSION.PHP_MINOR_VERSION;')/php-fpm.d/www.conf

# Set up WordPress and run FastCGI process manager
ENTRYPOINT \
while ! mariadb -h'mariadb' -u${mysql_admin} -p${mysql_admin_password} wordpress_database 2> /tmp/.tmpfile; \
do \
		grep -v "ERROR 2002 (HY000):" /tmp/.tmpfile >&2 \
	&&	sleep 3; \
done \
&&	rm -fr /tmp/.tmpfile \
&& \
if [ ! -f wp-config.php ]; then \
		wp config create --dbname=wordpress_database --dbuser=${mysql_admin} --dbpass=${mysql_admin_password} --dbhost=mariadb \
	&&	wp core install --url=${domain} --title=inception --admin_user=${wordpress_admin} --admin_password=${wordpress_admin_password} --admin_email=${wordpress_admin_email} \
	&&	wp user create ${wordpress_user} ${wordpress_email} --user_pass=${wordpress_password} --role=author --display_name=${wordpress_user} --porcelain \
	&&	wp theme install silverstorm --activate \
;fi \
&&	chown -R nobody:nobody /var/www/html \
&&	chmod -R 755 /var/www/html \
&&	exec /usr/sbin/php-fpm$(php -r 'echo PHP_MAJOR_VERSION.PHP_MINOR_VERSION;') -F -R
