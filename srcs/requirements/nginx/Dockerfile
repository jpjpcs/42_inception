# Use Debian Bullseye as the base image for the container
FROM debian:bullseye 

# Declare build-time arguments for SSL certificate paths and subject fields
ARG CRED_PATH CRED_CERT CRED_KEY COUNTRY STATE LOCALITY ORGANIZATION ORG_UNIT COMMON_NAME

# Update package lists, upgrade installed packages, and install NGINX, OpenSSL, and gettext-base
RUN apt update && apt upgrade -y && apt install -y nginx openssl gettext-base

# Create a directory for SSL certificates using the CRED_PATH variable
RUN mkdir -p ${CRED_PATH} #Substituted Added line RUN mkdir -p /etc/nginx/certs

# Generate a self-signed SSL certificate valid for 365 days with a 2048-bit RSA key
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ${CRED_PATH}/${CRED_KEY} -out ${CRED_PATH}/${CRED_CERT} -subj "/C=${COUNTRY}/ST=${STATE}/L=${LOCALITY}/O=${ORGANIZATION}/OU=${ORG_UNIT}/CN=${COMMON_NAME}"

# Copy the default NGINX configuration to a temporary file
COPY default ./tmp/nginx.conf 

# Substitute environment variables in the NGINX config and write to sites-available
RUN envsubst '$CRED_PATH $CRED_KEY $CRED_CERT $COMMON_NAME' < /tmp/nginx.conf > /etc/nginx/sites-available/default

# Set NGINX to run in the foreground as the container's main process
ENTRYPOINT ["nginx", "-g", "daemon off;"]
