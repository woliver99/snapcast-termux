#!/bin/bash

# Kill librespot and snapserver processes
kill $(pgrep -f librespot-player.jar)
kill $(pgrep -f snapserver)