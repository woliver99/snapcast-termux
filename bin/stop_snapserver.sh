#!/bin/bash

# Change directory to the location of the script
cd "$(dirname "$0")" || exit

# Kill librespot and snapserver processes
kill $(pgrep -f librespot-player.jar)
kill $(pgrep -f snapserver)