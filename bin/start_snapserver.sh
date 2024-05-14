#!/bin/bash

BASE_DIR="$(dirname "$(dirname "$(realpath "$0")")")"
cd "$BASE_DIR" || exit

# Stop the server if it's running
bash "./bin/stop_snapserver.sh"

# Copy the template configuration
cp "./snapcast/snapserver.template.conf" "./snapcast/snapserver.conf"

# Update the configuration file replacing {BASE_DIR} with the calculated path
sed -i "s|{BASE_DIR}|$BASE_DIR|g" "./snapcast/snapserver.conf"

# Check if the pipe directory exists, create it if not
if [ ! -d "./pipe" ]; then
    mkdir -p "./pipe"
fi

# Create FIFO file if it doesn't exist
if [ ! -p "./pipe/librespot.pcm" ]; then
    mkfifo "./pipe/librespot.pcm"
fi

bash "./bin/utilities/librespot_start.sh" &
bash "./bin/utilities/snapserver_start.sh" &

bash "./bin/ip_snapserver.sh"