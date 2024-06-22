#!/bin/bash

BASE_DIR="$(dirname "$(dirname "$(realpath "$0")")")"
cd "$BASE_DIR" || exit

bash "$BASE_DIR/bin/utilities/snapserver_stop.sh"
bash "$BASE_DIR/bin/utilities/snapserver_start.sh" & echo "Snapserver started successfully."