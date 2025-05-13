# Use Debian Bullseye as the base image for the container
FROM debian:bullseye

# Update package lists, upgrade packages, and install PHP-FPM, MySQLi, and curl
RUN apt update && apt upgrade -y && apt install -y \
php7.4-fpm \
php7.4-mysqli \
curl

# Create a directory for PHP runtime files and set ownership to www-data
RUN mkdir -p /run/php && chown -R www-data:www-data /run/php

# Copy the PHP-FPM pool configuration file
COPY www.conf /etc/php/7.4/fpm/pool.d/.

# Copy the WordPress installation script
COPY ./tools/wp-install.sh .

# Make the installation script executable (note: +X should be +x)
RUN chmod +X wp-install.sh

# Set the installation script as the container’s main process
ENTRYPOINT ["./wp-install.sh"]
