#!/bin/bash

# Change directory to the location of the script
cd "$(dirname "$0")" || exit

# Prompt for details
read -r -p "Enter IP: " ip
read -r -p "Enter port: " port
read -r -p "Enter name: " name

# Check if the name already exists in the configuration
if grep -q "#config:${name}" ./../snapcast/snapserver.conf; then
    echo "An output with the name '${name}' already exists. Please use a different name."
    exit 1
fi

# Add to configuration
echo "source = tcp://${ip}:${port}?name=${name}&mode=server #config:${name}" >> ./../snapcast/snapserver.conf

# Restart the server
bash "./bin/utilities/restart_snapserver.sh"