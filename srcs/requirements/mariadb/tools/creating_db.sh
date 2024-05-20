#!/bin/bash

# Start MariaDB service
service mariadb start

until mysqladmin ping -hlocalhost --silent; do
    sleep 3
done

# Allow external connections
echo "bind-address = 0.0.0.0" >> /etc/mysql/mariadb.conf.d/50-server.cnf

# Set up the database and user
mysql -u root <<MYSQL_SCRIPT
CREATE DATABASE IF NOT EXISTS $WORDPRESS_DB_NAME;
CREATE USER IF NOT EXISTS '$WORDPRESS_DB_USER'@'%' IDENTIFIED BY '$WORDPRESS_DB_PASSWORD';
GRANT ALL PRIVILEGES ON $WORDPRESS_DB_NAME.* TO '$WORDPRESS_DB_USER'@'%';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

# Stop MariaDB service to run it properly with CMD
service mariadb stop

# Start MariaDB in the foreground
exec mysqld_safe
