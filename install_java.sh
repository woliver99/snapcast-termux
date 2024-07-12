#!/bin/bash

# Change directory to the location of the script
cd "$(dirname "$0")" || exit

# Set the Java directory and download URL
java_dir="./java"
java_zip_url="https://maplenetwork.ca/cdn/java/17/termux.zip"
java_zip_file="termux-java.zip"

# Check if Java is already installed
if [ -d "$java_dir/bin" ]; then
    echo "Java is already installed."
    exit 0
fi

# Create the java directory if it does not exist
mkdir -p "$java_dir"

# Download Java
echo "Downloading Java..."
curl -L "$java_zip_url" -o "$java_zip_file"

# Check if the download was successful
if [ ! -f "$java_zip_file" ]; then
    echo "Failed to download Java."
    exit 1
fi

function cleanup {
    rm "$java_zip_file"
}

# Check if the zip package is already installed
if dpkg -s zip &>/dev/null; then
    echo "The 'zip' package is already installed."
else
    echo "The 'zip' package is not installed."
    read -r -p "Would you like to install it now? (y/n) " answer
    case $answer in
        [Yy]* )
            echo "Installing 'zip'..."
            pkg install zip
            ;;
        [Nn]* )
            echo "Installation aborted."
            cleanup
            exit 1
            ;;
        * )
            echo "Invalid input. Please answer 'y' or 'n'."
            cleanup
            exit 1
            ;;
    esac
fi

# Extract the Java package
echo "Extracting Java..."
unzip -o "$java_zip_file" -d "$java_dir"

# Set Permissions
chmod +x $java_dir/bin/*

cleanup

echo "Java installation complete."
