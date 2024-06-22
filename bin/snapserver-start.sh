#!/bin/bash

BASE_DIR="$(dirname "$(dirname "$(realpath "$0")")")"
cd "$BASE_DIR" || exit

# Stop the server if it's running
bash "$BASE_DIR/bin/snapserver-stop.sh"

# Copy the template configuration
cp "$BASE_DIR/snapcast/snapserver.template.conf" "$BASE_DIR/snapcast/snapserver.conf"

# Update the configuration file replacing {BASE_DIR} with the calculated path
sed -i "s|{BASE_DIR}|$BASE_DIR|g" "$BASE_DIR/snapcast/snapserver.conf"

# Create pipes
bash "$BASE_DIR/bin/utilities/create_pipes.sh"

bash "$BASE_DIR/bin/utilities/snapserver_start.sh" & echo "Snapserver started successfully."

bash "$BASE_DIR/bin/utilities/librespot_start.sh" & echo "Librespot started successfully."

bash "$BASE_DIR/bin/snapserver-ip.sh"