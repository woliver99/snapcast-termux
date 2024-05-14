#!/bin/bash

BASE_DIR="$(dirname "$(dirname "$(dirname "$(realpath "$0")")")")"
PID_DIR="$BASE_DIR/pid"
PID_FILE="$PID_DIR/librespot.pid"

# Check if the PID file exists
if [ -f "$PID_FILE" ]; then
    # Read the PID from the file and send SIGTERM for a graceful shutdown
    kill -SIGTERM "$(cat "$PID_FILE")"
    # Wait for the process to exit
    wait "$(cat "$PID_FILE")"
    # Remove the PID file
    rm -f "$PID_FILE"
    echo "Librespot stopped successfully."
else
    echo "PID file not found. Is librespot running?"
fi
