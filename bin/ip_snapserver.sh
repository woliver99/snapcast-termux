#!/bin/bash

# Change directory to the location of the script
cd "$(dirname "$0")" || exit

# Get the full output from ifconfig
ifconfig_output=$(ifconfig 2>/dev/null)

# Extract the IP address for wlan0
ip=$(echo "$ifconfig_output" | awk '/wlan0:/,0' | grep 'inet ' | awk '{print $2}')

# Check if IP was found
if [ -z "$ip" ]; then
    echo "No IP address found for wlan0. Make sure you are connected to a network."
    exit 1
fi

# Print IP with port
echo "Current IP: ${ip}:80"
