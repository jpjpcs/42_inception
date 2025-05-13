#!/bin/bash

# Write SQL commands to initialize the database# Create an SQL command to create a database if it doesn’t exist, writing to init.sql
echo "CREATE DATABASE IF NOT EXISTS $DB_NAME;" > /etc/mysql/init.sql

# Append an SQL command to create a user with a password, allowing connections from any host
echo "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';" >> /etc/mysql/init.sql

# Append an SQL command to grant all privileges to the user on all databases
echo "GRANT ALL PRIVILEGES ON *.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD' WITH GRANT OPTION;" >> /etc/mysql/init.sql

# Append an SQL command to reload privilege tables
echo "FLUSH PRIVILEGES;" >> /etc/mysql/init.sql

# Wait for a few seconds to ensure services are ready
sleep 5

# Initialize the MariaDB data directory and system tables
mysql_install_db 

# Launch MariaDB server (mysqld reads /etc/mysql/init.sql at startup)
mysqld

