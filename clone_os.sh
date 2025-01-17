#!/bin/bash

# Function to calculate MD5 hash of a device/file
calculate_hash() {
    local device=$1
    md5sum "$device"
}

# Function to validate user input
validate_input() {
    if [ ! -e "$1" ]; then
        echo "Error: Device $1 does not exist!"
        exit 1
    fi
}

# Clear screen
clear

# Welcome message
echo "=== OS Cloning Tool ==="
echo "This tool will help you clone/mirror your system"
echo "----------------------------------------"

# Get source device
read -p "Enter source device (e.g., /dev/sda): " SOURCE_DEVICE
validate_input "$SOURCE_DEVICE"

# Get destination device
read -p "Enter destination device (e.g., /dev/sdb): " DEST_DEVICE
validate_input "$DEST_DEVICE"

# Confirm operation
echo "WARNING: This will ERASE ALL DATA on $DEST_DEVICE!"
read -p "Are you sure you want to continue? (yes/no): " CONFIRM

if [ "$CONFIRM" != "yes" ]; then
    echo "Operation cancelled by user"
    exit 0
fi

# Calculate source hash before copying
echo "Calculating source hash..."
SOURCE_HASH=$(calculate_hash "$SOURCE_DEVICE")
echo "Source hash: $SOURCE_HASH"

# Perform the cloning
echo "Starting cloning process..."
echo "This may take a while depending on the size of your drive..."

dd if="$SOURCE_DEVICE" of="$DEST_DEVICE" bs=4M status=progress conv=noerror,sync

# Calculate destination hash after copying
echo "Calculating destination hash..."
DEST_HASH=$(calculate_hash "$DEST_DEVICE")
echo "Destination hash: $DEST_HASH"

# Compare hashes
if [ "$SOURCE_HASH" = "$DEST_HASH" ]; then
    echo "Hash verification successful! Cloning completed successfully."
else
    echo "WARNING: Hash mismatch! The cloned drive may not be identical to the source."
    echo "Source hash: $SOURCE_HASH"
    echo "Destination hash: $DEST_HASH"
fi