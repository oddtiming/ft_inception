# Use the Debian Buster base image
FROM debian:buster

# NOTE: For testing
ENV MYSQL_DB_NAME=wordpress_db
ENV WP_DB_PASSWORD=iyahoui123
ENV WP_DB_PATH=/var/www/html



# Set the working directory
WORKDIR /var/www/html

# Install dependencies
RUN apt-get update && apt-get install -y \
    php-fpm \
    php-mysql \
    mariadb-client \
    systemd \
    wget \
    unzip \
    curl

# Download and extract the latest version of WordPress
RUN wget https://wordpress.org/latest.zip \
    && unzip latest.zip \
    && rm latest.zip \
    && mv wordpress/* .

RUN ls -la

# Get and install the wp-cli 
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

# Copy the PHP-FPM configuration file
COPY wordpress.conf /etc/php/7.4/fpm/pool.d/

# Copy the setup configuration script
COPY entrypoint_debian.sh ./entry.sh
RUN chmod +x ./entry.sh

# Set the user and group to run PHP-FPM
RUN usermod -u 1000 www-data \
    && groupmod -g 1000 www-data

# Expose the PHP-FPM port
EXPOSE 9000

# First run the entrypoint script
ENTRYPOINT [ "./entry.sh" ]

# Start the PHP-FPM service in the foreground, run as root
CMD ["php-fpm7.3", "-F"]


# # Use the latest Alpine Linux image as the base image
# FROM alpine:3.16

# # Set environment variables for the image
# ENV WORDPRESS_VERSION 5.7
# ENV WORDPRESS_SHA1 95462280e1bafdabf3ac3b6c8b6f27d3cf3c9cd3

# # Install dependencies
# RUN apk update && apk upgrade
# RUN apk search php7

# # Download WordPress
# RUN curl -o wordpress.tar.gz -SL https://wordpress.org/wordpress-${WORDPRESS_VERSION}.tar.gz \
#     && echo "$WORDPRESS_SHA1 *wordpress.tar.gz" | sha1sum -c - \
#     && tar -xzf wordpress.tar.gz -C /var/www/ \
#     && rm wordpress.tar.gz

# # Copy the WordPress files to the root of the web server
# RUN mv /var/www/wordpress /var/www/html

# # Configure PHP-FPM to listen on port 9000
# RUN sed -i 's/;listen.port = 9000/listen.port = 9000/g' /etc/php7/php-fpm.d/www.conf

# # Expose the 9000 port
# EXPOSE 9000

# # Start the PHP-FPM service in the background
# CMD ["php-fpm7", "-F"]
