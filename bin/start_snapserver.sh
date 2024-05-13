#!/bin/bash

# Define the base directory as one level up from the location of the script
BASE_DIR="$(dirname "$(realpath "$0")")/.."

# Stop the server if it's running
"$BASE_DIR/bin/stop_snapserver.sh"

# Copy the template configuration
cp "$BASE_DIR/snapcast/snapserver.template.conf" "$BASE_DIR/snapcast/snapserver.conf"

# Update the configuration file replacing {BASE_DIR} with the calculated path
sed -i "s|{BASE_DIR}|$BASE_DIR|g" "$BASE_DIR/snapcast/snapserver.conf"

# Check if the pipe directory exists, create it if not
if [ ! -d "$BASE_DIR/pipe" ]; then
    mkdir -p "$BASE_DIR/pipe"
fi

# Create FIFO file if it doesn't exist
if [ ! -p "$BASE_DIR/pipe/librespot.pcm" ]; then
    mkfifo "$BASE_DIR/pipe/librespot.pcm"
fi

# Start librespot
su -c "(cd '$BASE_DIR/librespot' && '$BASE_DIR/java/bin/java' -jar librespot-player.jar)" > /dev/null 2>&1 &

# Start snapserver with the updated configuration
snapserver -c "$BASE_DIR/snapcast/snapserver.conf" > /dev/null 2>&1 &

# Run IP snapserver script
"$BASE_DIR/bin/ip_snapserver.sh"