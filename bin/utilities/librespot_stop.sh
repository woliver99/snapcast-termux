#!/bin/bash

BASE_DIR="$(dirname "$(dirname "$(dirname "$(realpath "$0")")")")"
PID_DIR="$BASE_DIR/pid"
PID_FILE="$PID_DIR/librespot.pid"
PIPE_DIR="$BASE_DIR/pipe"

# Check if the PID file exists
if [ -f "$PID_FILE" ]; then
    # Read the PID from the file and send SIGTERM for a graceful shutdown
    kill -SIGTERM "$(cat "$PID_FILE")"
    # Wait for the process to exit
    while kill -0 "$PID" 2>/dev/null; do
        sleep 1 # wait 1 second before checking again
    done
    # Remove the PID file
    rm -f "$PID_FILE"

    # Kill the FFmpeg process
    pkill -9 "ffmpeg -y -f s16le -ar 44100 -ac 2 -i $PIPE_DIR/librespot.pcm -ar 48000 -f s16le $PIPE_DIR/librespot_resampled.pcm" > /dev/null 2>&1

    echo "Librespot stopped successfully."
else
    echo "Librespot is not running."
fi
