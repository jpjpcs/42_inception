#!/bin/bash

# Change to the web root directory for WordPress files
cd /var/www/html

# Check if WP-CLI is not installed
if [ ! -f ./wp-cli.phar ]; then

    # Download WP-CLI from its official GitHub repository
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

    # Make WP-CLI executable
    chmod +x wp-cli.phar
fi

# Pause for 5 seconds to ensure MariaDB is ready
sleep 5

# Check if WordPress configuration file does not exist
if [ ! -f ./wp-config.php ]; then

    # Download WordPress core files using WP-CLI
    ./wp-cli.phar core download --allow-root

    # Create wp-config.php with database settings
    ./wp-cli.phar config create \
        --dbname=${DB_NAME} \
        --dbuser=${DB_USER} \
        --dbpass=${DB_PASSWORD} \
        --dbhost=${DB_HOST} \
        --allow-root
fi

# Check if WordPress is not installed and install if not installed
if ! ./wp-cli.phar core is-installed --allow-root; then

    # Install WordPress with site details
    ./wp-cli.phar core install \
        --url=${WP_DOMAIN} \
        --title=${WP_TITLE} \
        --admin_user=${WP_ADMIN_USER} \
        --admin_password=${WP_ADMIN_PASSWORD} \
        --admin_email=${WP_ADMIN_EMAIL} \
        --allow-root

    # Create a subscriber user
    ./wp-cli.phar user create \
        ${WP_GUEST_USER} \
        ${WP_GUEST_EMAIL} \
        --role=subscriber \
        --user_pass=${WP_GUEST_PASSWORD} \
        --allow-root
fi

# Start PHP-FPM in the foreground
php-fpm7.4 -F
