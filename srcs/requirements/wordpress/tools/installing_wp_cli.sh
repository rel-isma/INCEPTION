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

# creating file wp-config.php
wp config create --dbname=$WORDPRESS_DB_NAME --dbuser=$WORDPRESS_DB_USER \
  --dbpass=$WORDPRESS_DB_PASSWORD --dbhost=mariadb:3306 --allow-root


# install wordpress
wp core install --url=$WORDPRESS_URL --title="$WORDPRESS_TITLE" \
  --admin_user=$WORDPRESS_ADMIN_USER --admin_password=$WORDPRESS_ADMIN_PASSWORD --admin_email=$WORDPRESS_ADMIN_EMAIL --allow-root

# Create WordPress user
wp user create $WP_USER_NAME $WP_USER_EMAIL --role=$WP_USER_ROLE --user_pass=$WP_USER_PASSWORD --allow-root

chown -R www-data:www-data /var/www/html

# Execute CMD
exec "$@"
