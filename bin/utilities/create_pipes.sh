#!/bin/bash

BASE_DIR="$(dirname "$(dirname "$(dirname "$(realpath "$0")")")")"
PIPE_DIR="$BASE_DIR/pipe"

# Make directory
if [ ! -d "$PIPE_DIR" ]; then
    mkdir -p "$PIPE_DIR"
fi

# Create librespot pipe
if [ -p "$PIPE_DIR/librespot.pcm" ]; then
    rm "$PIPE_DIR/librespot.pcm"
fi
mkfifo "$PIPE_DIR/librespot.pcm"

# Create librespot_resampled pipe
if [ -p "$PIPE_DIR/librespot_resampled.pcm" ]; then
    rm "$PIPE_DIR/librespot_resampled.pcm"
fi
mkfifo "$PIPE_DIR/librespot_resampled.pcm"