#!/bin/bash

kill $(pgrep -f snapserver)

(cd ./../librespot && ./../java/bin/java -jar librespot-player.jar) &