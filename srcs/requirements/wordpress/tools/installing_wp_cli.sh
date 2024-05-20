#!/bin/bash

# Function to wait for MariaDB to be ready
wait_for_mariadb() {
  echo "Waiting for MariaDB to be ready..."
  while ! mysqladmin ping -hmariadb --silent; do
    echo "MariaDB is unavailable - waiting..."
    sleep 3
  done
  echo "MariaDB is up and running!"
}

# Wait for MariaDB to be ready
wait_for_mariadb

# Install WordPress
wp core download --allow-root
wp config create --dbname=wordpress_db --dbuser=wp_user --dbpass=password --dbhost=mariadb:3306 --allow-root
wp core install --url=https://localhost:8443 --title="My WordPress Site" --admin_user=admin --admin_password=admin --admin_email=codeing.ch@gmail.com --allow-root
wp user create rel-isma relismaiyly@gmail.com --role=author --user_pass=2001 --allow-root

chown -R www-data:www-data /var/www/html

# Execute CMD
exec "$@"
