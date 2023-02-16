#!/bin/bash
set -Eeuxo pipefail

# Downloading and extracting WordPress
wget https://wordpress.org/latest.tar.gz
tar xvf latest.tar.gz
mv wordpress /var/www/html/

# Configuring PHP-FPM to listen on port 9000
sed -i 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 0.0.0.0:9000/g' /etc/php7/php-fpm.d/www.conf

# Starting PHP-FPM
/usr/sbin/php-fpm7
