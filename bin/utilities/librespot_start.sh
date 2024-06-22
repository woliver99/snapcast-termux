#!/bin/bash

BASE_DIR="$(dirname "$(dirname "$(dirname "$(realpath "$0")")")")"
PID_DIR="$BASE_DIR/pid"
PID_FILE="$PID_DIR/librespot.pid"
PIPE_DIR="$BASE_DIR/pipe"

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

# Start FFmpeg to resample audio from 44.1kHz to 48kHz and output to a file
ffmpeg -y -f s16le -ar 44100 -ac 2 -i "$PIPE_DIR/librespot.pcm" -ar 48000 -f s16le "$PIPE_DIR/librespot_resampled.pcm" > /dev/null 2>&1 &

FFMPEG_PID=$!

# Function to handle SIGINT
function handle_sigint {
    echo "Stopping librespot and FFmpeg..."
    kill -SIGINT "$LIBRESPOT_PID"
    wait "$LIBRESPOT_PID"
    kill -9 "$FFMPEG_PID"
    wait "$FFMPEG_PID"
    rm -f "$PID_FILE"
    exit 0
}

# Trap SIGINT and call the handler function
trap 'handle_sigint' SIGINT

# Keep script running to maintain trap active
wait $LIBRESPOT_PID