#!/bin/bash

# Change directory to the location of the script
cd "$(dirname "$0")" || exit

kill $(pgrep -f snapserver)

(cd ./../librespot && ./../java/bin/java -jar librespot-player.jar) &