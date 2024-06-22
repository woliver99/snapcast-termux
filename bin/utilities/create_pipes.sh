#!/bin/bash

BASE_DIR="$(dirname "$(dirname "$(dirname "$(realpath "$0")")")")"
PIPE_DIR="$BASE_DIR/pipe"

# Make directory
if [ ! -d "$PIPE_DIR" ]; then
    mkdir -p "$PIPE_DIR"
fi

# Create librespot pipe
if [ ! -p "$PIPE_DIR/librespot.pcm" ]; then
    mkfifo "$PIPE_DIR/librespot.pcm"
fi