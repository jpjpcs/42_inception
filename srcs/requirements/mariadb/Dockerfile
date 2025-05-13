# Use Debian Bullseye as the base image for the container
FROM debian:bullseye 

# Update package lists, upgrade packages, and install MariaDB server
RUN apt update && apt upgrade -y && apt install -y mariadb-server

# Copy the MariaDB server configuration file to the configuration directory
COPY 50-server.cnf /etc/mysql/mariadb.conf.d/.

# Commented-out line for copying an init.sql file (not used)
 #Deleted line -> COPY init.sql /etc/mysql/init.sql
#COPY init.sql /etc/mysql/init.sql

# Create a directory for MariaDB runtime files (e.g., PID and socket)
RUN mkdir /run/mysqld

# Copy the MariaDB startup script to the container
COPY tools/mariadb-run.sh .

# Make the startup script executable
RUN chmod +x ./mariadb-run.sh

# Set the startup script as the container’s main process
ENTRYPOINT ["./mariadb-run.sh"]
