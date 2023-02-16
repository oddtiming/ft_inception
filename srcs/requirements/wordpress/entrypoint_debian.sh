#!/bin/bash

set -Eeuxo pipefail

# Get the PHP version in the format "7.3"
php_version=$(php -r 'echo PHP_MAJOR_VERSION.".".PHP_MINOR_VERSION;')

# Configure php-fpm to listen on port 9000
sed -i "s/listen = .*/listen = 0.0.0.0:9000/" /etc/php/$php_version/fpm/pool.d/www.conf


# This file resides in the shared volume
wp_conf_file="/var/www/html/wp-config.php"
# wp_conf_file="$WP_DB_PATH/wp-config.php"

# Check if WordPress has already been set up on the volume
if [ -f $wp_conf_file ]; then
  echo "$wp_conf_file is already set. Exiting."
  exit 0
fi

mariadb -hmariadb -u$MYSQL_USER -p$MYSQL_PASSWORD --database=$MYSQL_DATABASE <<<'SELECT 1;'
# cat /var/run/mysqld/mysqld.sock
wp config create --allow-root \
    --dbname=mariadb \
    --dbuser=bob \
    --dbpass=bob \
    --locale=ro_RO \
    --dbhost=mariadb:3306 \
    --path="/var/www/html"

apt-get install net-tools
netstat -an | grep 9000
apt-get install lsof
lsof -i :9000

exec "$@"
# # Configure WordPress to use the MariaDB database on port 3306
# sed -i "s/define('DB_HOST', 'localhost');/define('DB_HOST', 'mariadb:3306');/" /etc/wordpress/config-localhost.php

# # Copy the WordPress configuration file to the correct location
# cp /etc/wordpress/config-localhost.php /etc/wordpress/config-default.php

