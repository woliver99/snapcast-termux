#!/bin/bash

BIN_DIR="$(dirname "$(realpath "$0")")"/bin

# Path to the .bashrc file
BASHRC="$HOME/.bashrc"

# Check if BIN_DIR is already in the .bashrc
if grep -q "$BIN_DIR" "$BASHRC"; then
    echo "BIN_DIR is already in the .bashrc."
else
    # If not found, add BIN_DIR to the .bashrc
    echo "Adding BIN_DIR to .bashrc..."
    echo "export PATH=\$PATH:$BIN_DIR" >> "$BASHRC"
    echo "Sourcing .bashrc to apply changes..."
    source "$BASHRC"
    echo "Changes applied successfully."
fi

bash "$BIN_DIR/../install_java.sh"