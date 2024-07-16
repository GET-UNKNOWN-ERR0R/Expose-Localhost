#!/bin/bash

# Prompt the user to input a link
read -p "Enter the link (with http:// or https://) you want to expose: " LINK

# Extract the protocol, hostname, and port from the link
PROTOCOL=$(echo $LINK | awk -F[/:] '{print $1}')
HOSTNAME=$(echo $LINK | awk -F[/:] '{print $4}')
PORT=$(echo $LINK | awk -F[/:] '{print $5}')

# If no port is specified, default to 80 for HTTP and 443 for HTTPS
if [[ $PROTOCOL == "https" ]]; then
    PORT=${PORT:-443}
else
    PORT=${PORT:-80}
fi

