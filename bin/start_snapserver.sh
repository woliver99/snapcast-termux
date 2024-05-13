#!/bin/bash

# Stop the server if it's running
./stop_snapserver

# Copy the template configuration
cp ./../snapcast/snapserver.template.conf ./../snapcast/snapserver.conf

# Create FIFO file if it doesn't exist
if [ ! -p ./../pipe/librespot.pcm ]; then
    mkfifo ./../pipe/librespot.pcm
fi

# Start librespot
su -c "(cd ./../librespot && ./../java/bin/java -jar librespot-player.jar) &"

# Start snapserver
snapserver -c ./../snapcast/snapserver.conf &

# Run IP snapserver script
./ip_snapserver.sh
