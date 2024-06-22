#!/bin/bash

BASE_DIR="$(dirname "$(dirname "$(realpath "$0")")")"
cd "$BASE_DIR" || exit

# Display TCP servers with line numbers
echo "Select a TCP server to remove:"
grep -n '#config:' "$BASE_DIR/snapcast/snapserver.conf"

# Get user input
read -r -p "Enter line number: " line_num

# Remove the selected line
sed -i "${line_num}d" "$BASE_DIR/snapcast/snapserver.conf"

# Restart the server
bash "$BASE_DIR/bin/snapserver-restart.sh"