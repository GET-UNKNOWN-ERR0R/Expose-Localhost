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

# Print extracted values for debugging
echo "Protocol: $PROTOCOL"
echo "Hostname: $HOSTNAME"
echo "Port: $PORT"

# Create Serveo tunnel for exposing the service
if [[ $HOSTNAME == "localhost" ]] || [[ $HOSTNAME == "127.0.0.1" ]]; then
    # Use Serveo to forward a public URL to the local server
    ssh -R 80:localhost:$PORT serveo.net
else
    # Use Serveo to forward a public URL to the remote server
    ssh -R 80:$HOSTNAME:$PORT serveo.net
fi
