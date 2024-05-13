#!/bin/bash

# Prompt for details
read -p "Enter IP: " ip
read -p "Enter port: " port
read -p "Enter name: " name

# Check if the name already exists in the configuration
if grep -q "#config:${name}" ./../snapcast/snapserver.conf; then
    echo "An output with the name '${name}' already exists. Please use a different name."
    exit 1
fi

# Add to configuration
echo "tcp://${ip}:${port}?name=${name}&mode=server #config:${name}" >> ./../snapcast/snapserver.conf

# Restart the server
./restart_snapserver