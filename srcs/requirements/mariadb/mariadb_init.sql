CREATE DATABASE IF NOT EXISTS $MYSQL_DB_NAME CHARACTER SET utf8;

CREATE USER 'myMariadbUser'@'%' IDENTIFIED BY 'myMariadbPassword';
GRANT ALL PRIVILEGES ON $MYSQL_DB_NAME.* TO 'myMariadbUser'@'%';

ALTER USER 'root'@'localhost' IDENTIFIED BY 'myMariadbRootPassword';
FLUSH PRIVILEGES;