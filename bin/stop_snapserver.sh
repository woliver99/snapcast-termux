#!/bin/bash

cd "$(dirname "$0")" || exit

bash "./utilities/snapserver_stop.sh"
bash "./utilities/librespot_stop.sh"