#!/bin/bash

BASE_DIR="$(dirname "$(dirname "$(realpath "$0")")")"
cd "$BASE_DIR" || exit

# Prompt for details
read -r -p "Enter IP: " ip
read -r -p "Enter port: " port
read -r -p "Enter name: " name

# Check if the name already exists in the configuration
if grep -q "#config:${name}" "$BASE_DIR/snapcast/snapserver.conf"; then
    echo "An output with the name '${name}' already exists. Please use a different name."
    exit 1
fi

# Add to configuration
echo "source = tcp://${ip}:${port}?name=${name}&mode=server #config:${name}" >> "$BASE_DIR/snapcast/snapserver.conf"

# Restart the server
bash "$BASE_DIR/bin/utilities/restart_snapserver.sh"