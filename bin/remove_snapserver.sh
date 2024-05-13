#!/bin/bash

# Change directory to the location of the script
cd "$(dirname "$0")" || exit

# Display TCP servers with line numbers
echo "Select a TCP server to remove:"
grep -n '#config:' ./../snapcast/snapserver.conf

# Get user input
read -p "Enter line number: " line_num

# Remove the selected line
sed -i "${line_num}d" ./../snapcast/snapserver.conf

# Restart the server
./restart_snapserver