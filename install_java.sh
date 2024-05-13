#!/bin/bash

# Set the Java directory and download URL
java_dir="./java"
java_zip_url="https://maplenetwork.ca/hosted_storage/termux-java.zip"
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

pkg install zip

# Extract the Java package
echo "Extracting Java..."
unzip -o "$java_zip_file" -d "$java_dir"

# Clean up the zip file
rm "$java_zip_file"

echo "Java installation complete."
