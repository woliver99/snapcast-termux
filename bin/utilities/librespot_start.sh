#!/bin/bash

BASE_DIR="$(dirname "$(dirname "$(dirname "$(realpath "$0")")")")"
PID_DIR="$BASE_DIR/pid"
PID_FILE="$PID_DIR/librespot.pid"

# Ensure the PID directory exists
mkdir -p "$PID_DIR"

# Check if librespot is already running
if [ -f "$PID_FILE" ] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then
    echo "Librespot is already running."
    exit 1
fi

# Start librespot in the background as a different user and redirect output
su -c "(cd '$BASE_DIR/librespot' && '$BASE_DIR/java/bin/java' -jar librespot-player.jar)" > /dev/null 2>&1 &

LIBRESPOT_PID=$!
echo $LIBRESPOT_PID > "$PID_FILE"

# Function to handle SIGINT
function handle_sigint {
    echo "Stopping librespot..."
    kill -SIGINT "$LIBRESPOT_PID"
    wait "$LIBRESPOT_PID"
    rm -f "$PID_FILE"
    exit 0
}

# Trap SIGINT and call the handler function
trap 'handle_sigint' SIGINT

# Keep script running to maintain trap active
wait $LIBRESPOT_PID
