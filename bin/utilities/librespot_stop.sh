#!/bin/bash

BASE_DIR="$(dirname "$(dirname "$(dirname "$(realpath "$0")")")")"
PID_DIR="$BASE_DIR/pid"
PID_FILE="$PID_DIR/librespot.pid"

# Check if the PID file exists
if [ -f "$PID_FILE" ]; then
    # Read the PID from the file and send SIGTERM for a graceful shutdown
    kill -SIGTERM "$(cat "$PID_FILE")"
    # Wait for the process to exit
    while kill -0 "$PID" 2>/dev/null; do
        sleep 1 # wait 1 second before checking again
    done

    # Kill ffmpeg
    pkill -9 "ffmpeg"

    # Remove the PID file
    rm -f "$PID_FILE"
    
    echo "Librespot stopped successfully."
else
    echo "Librespot is not running."
fi
