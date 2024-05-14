#!/bin/bash

PID_DIR="$(dirname "$(dirname "$(dirname "$(realpath "$0")")")")/pid"
PID_FILE="$PID_DIR/snapserver.pid"

# Check if the PID file exists
if [ -f "$PID_FILE" ]; then
    # Read the PID from the file and kill the process
    kill -SIGINT "$(cat "$PID_FILE")"
    # Wait for the process to exit gracefully
    wait "$(cat "$PID_FILE")"
    # Remove the PID file
    rm -f "$PID_FILE"
    echo "Snapserver stopped successfully."
else
    echo "PID file not found. Is snapserver running?"
fi