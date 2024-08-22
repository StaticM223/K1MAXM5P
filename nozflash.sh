#!/bin/sh

# Define file name patterns and URL
URL="https://raw.githubusercontent.com/StaticM223/K1MAXM5P/main/noz0_120_G30-noz0_014_000.bin"
START=0
END=50
STEP=5

# Function to pause for a random time between 1 and 3 seconds
pause() {
    local RAND_DELAY=$((1 + RANDOM % 3))
    sleep $RAND_DELAY
}

# Function to delete files in a range
delete_files() {
    for i in $(seq -f "%03g" $START $STEP $END); do
        FILE="noz0_120_G30-noz0_${i}_000.bin"
        if [ -f "$1/$FILE" ]; then
            echo "Deleting old firmware: $FILE..."
            rm "$1/$FILE"
            pause
        fi
    done
}

echo "Starting firmware update process..."
pause

# Check for /usr/share/klipper directory
if [ -d /usr/share/klipper ]; then
    echo "Directory /usr/share/klipper exists."
    pause
    echo "Deleting old firmware..."
    delete_files "/usr/share/klipper/fw/K1"
    echo "Patching Kernel..."
    # Add your kernel patching command here if needed
    pause
    echo "Downloading latest firmware..."
    if wget --no-check-certificate -P /usr/share/klipper/fw/K1/ $URL; then
        echo "Patching latest firmware..."
        # Add your firmware patching command here if needed
        pause
        echo "Firmware update successful!"
    else
        echo "wget failed with error code $?."
        exit 1
    fi

# Check for /usr/data/klipper directory
elif [ -d /usr/data/klipper ]; then
    echo "Directory /usr/data/klipper exists."
    pause
    echo "Deleting old firmware..."
    delete_files "/usr/data/klipper/fw/K1"
    echo "Patching Kernel..."
    # Add your kernel patching command here if needed
    pause
    echo "Downloading latest firmware..."
    if wget --no-check-certificate -P /usr/data/klipper/fw/K1/ $URL; then
        echo "Patching latest firmware..."
        # Add your firmware patching command here if needed
        pause
        echo "Firmware update successful!"
    else
        echo "wget failed with error code $?."
        exit 1
    fi

else
    echo "Neither /usr/share/klipper nor /usr/data/klipper directory exists."
    exit 1
fi
