#!/bin/sh

# Define file names and URL
FILE1="noz0_120_G30-noz0_003_000.bin"
FILE2="noz0_120_G30-noz0_005_000.bin"  # Alternative file to try if FILE1 is not found
URL="https://raw.githubusercontent.com/StaticM223/K1MAXM5P/main/noz0_120_G30-noz0_014_000.bin"

echo "Checking directory and downloading files..."

# Check for /usr/share/klipper directory
if [ -d /usr/share/klipper ]; then
    echo "Directory /usr/share/klipper exists."
    if [ -f /usr/share/klipper/fw/K1/$FILE1 ]; then
        echo "Removing old file $FILE1..."
        rm /usr/share/klipper/fw/K1/$FILE1
    elif [ -f /usr/share/klipper/fw/K1/$FILE2 ]; then
        echo "Removing old file $FILE2..."
        rm /usr/share/klipper/fw/K1/$FILE2
    fi
    echo "Downloading new file..."
    wget --no-check-certificate -P /usr/share/klipper/fw/K1/ $URL || {
        echo "wget failed with error code $?."
        exit 1
    }

# Check for /usr/data/klipper directory
elif [ -d /usr/data/klipper ]; then
    echo "Directory /usr/data/klipper exists."
    if [ -f /usr/data/klipper/fw/K1/$FILE1 ]; then
        echo "Removing old file $FILE1..."
        rm /usr/data/klipper/fw/K1/$FILE1
    elif [ -f /usr/data/klipper/fw/K1/$FILE2 ]; then
        echo "Removing old file $FILE2..."
        rm /usr/data/klipper/fw/K1/$FILE2
    fi
    echo "Downloading new file..."
    wget --no-check-certificate -P /usr/data/klipper/fw/K1/ $URL || {
        echo "wget failed with error code $?."
        exit 1
    }

else
    echo "Neither /usr/share/klipper nor /usr/data/klipper directory exists."
fi
