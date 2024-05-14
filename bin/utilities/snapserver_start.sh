#!/bin/bash

BASE_DIR="$(dirname "$(dirname "$(dirname "$(realpath "$0")")")")"
PID_DIR="$BASE_DIR/pid"
PID_FILE="$PID_DIR/snapserver.pid"

# Check if the PID directory exists, create it if not
if [ ! -d "$PID_DIR" ]; then
    mkdir -p "$PID_DIR"
fi

# Check if snapserver is already running
if [ -f "$PID_FILE" ] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then
    echo "Snapserver is already running."
    exit 1
fi

# Start snapserver in the background and redirect output
snapserver -c "$BASE_DIR/snapcast/snapserver.conf" > /dev/null 2>&1 &

SNAP_PID=$!
echo $SNAP_PID > "$PID_FILE"

# Function to handle SIGINT
function handle_sigint {
    echo "Stopping snapserver..."
    kill -SIGINT "$SNAP_PID"
    wait "$SNAP_PID"
    rm -f "$PID_FILE"
    exit 0
}

# Trap SIGINT and call the handler function
trap 'handle_sigint' SIGINT

# Keep script running to maintain trap active
wait $SNAP_PID
