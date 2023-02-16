# Build from pen-ultimate version of debian
FROM debian:buster

ENV MYSQL_USER=bob
ENV MYSQL_PASSWORD=bob
ENV MYSQL_ROOT_PASSWORD=bob
ENV MYSQL_DATA_DIR=/var/lib/mysql
ENV MYSQL_DB_NAME=wordpress_db

# Update package manager and install db non-interactively
RUN apt-get update -y && apt-get install mariadb-server tini -y

# Configure MariaDB to listen to localhost
RUN sed -i 's/bind-address/bind-address = 0.0.0.0 #/i' /etc/mysql/mariadb.conf.d/50-server.cnf

# Establish a temporary location to copy the script
WORKDIR /tmp

# Copy the init script into the container
COPY mariadb_init.sql ./

# Configure the script with the proper values
RUN sed -i "s/myMariadbUser/$MYSQL_USER/i" mariadb_init.sql
RUN sed -i "s/myMariadbPassword/$MYSQL_PASSWORD/i" mariadb_init.sql
RUN sed -i "s/myMariadbRootPassword/$MYSQL_ROOT_PASSWORD/i" mariadb_init.sql
RUN cat mariadb_init.sql

EXPOSE 3306

# Configure MariaDB to listen to localhost
RUN ls -laR /etc/init.d/
RUN /etc/init.d/mysql start && mysql -e "source mariadb_init.sql"

CMD ["mysqld"]
