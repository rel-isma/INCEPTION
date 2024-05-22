#!/bin/bash

# Create directories for the SSL certificates
mkdir -p /etc/nginx/certs

# Generate a self-signed SSL certificate
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/certs/selfsigned.key \
    -out /etc/nginx/certs/selfsigned.crt \
    -subj "/C=MA/ST=Morocco/L=khouribga/O=1337 future is loading/CN=rel-isma.42.fr"
