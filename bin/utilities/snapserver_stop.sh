#!/bin/bash

PID_DIR="$(dirname "$(dirname "$(dirname "$(realpath "$0")")")")/pid"
PID_FILE="$PID_DIR/snapserver.pid"

# Check if the PID file exists
if [ -f "$PID_FILE" ]; then
    # Read the PID from the file and kill the process
    kill -SIGINT "$(cat "$PID_FILE")"
    # Wait for the process to exit gracefully
    while kill -0 "$PID" 2>/dev/null; do
        sleep 1 # wait 1 second before checking again
    done
    # Remove the PID file
    rm -f "$PID_FILE"
    echo "Snapserver stopped successfully."
else
    echo "Snapserver is not running."
fi