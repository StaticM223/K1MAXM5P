!/bin/sh

# Define color codes
COLOR_RESET="\033[0m"
COLOR_GREEN="\033[32m"
COLOR_YELLOW="\033[33m"
COLOR_RED="\033[31m"

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
    local DIR=$1
    for i in $(seq $START $STEP $END); do
        FILE=$(printf "noz0_120_G30-noz0_%03d_000.bin" $i)
        if [ -f "$DIR/$FILE" ]; then
            echo -e "${COLOR_YELLOW}Deleting old firmware: $FILE...${COLOR_RESET}"
            rm "$DIR/$FILE"
            echo -e "${COLOR_GREEN}Successfully deleted $FILE.${COLOR_RESET}"
            pause
        else
            echo -e "${COLOR_RED}File not found: $FILE.${COLOR_RESET}"
        fi
    done
}

echo -e "${COLOR_GREEN}Starting firmware update process...${COLOR_RESET}"
pause

# Check for /usr/share/klipper directory
if [ -d /usr/share/klipper ]; then
    echo -e "${COLOR_GREEN}Directory /usr/share/klipper exists.${COLOR_RESET}"
    pause
    echo -e "${COLOR_YELLOW}Deleting old firmware...${COLOR_RESET}"
    delete_files "/usr/share/klipper/fw/K1"
    echo -e "${COLOR_YELLOW}Patching Kernel...${COLOR_RESET}"
    # Add your kernel patching command here if needed
    pause
    echo -e "${COLOR_YELLOW}Downloading latest firmware...${COLOR_RESET}"
    FILE="/usr/share/klipper/fw/K1/$(basename $URL)"
    [ -f "$FILE" ] && rm "$FILE"  # Remove existing file if it exists
    if wget --no-check-certificate -P /usr/share/klipper/fw/K1/ $URL; then
        echo -e "${COLOR_YELLOW}Patching latest firmware...${COLOR_RESET}"
        # Add your firmware patching command here if needed
        pause
        echo -e "${COLOR_GREEN}Firmware update successful!${COLOR_RESET}"
    else
        echo -e "${COLOR_RED}wget failed with error code $?.${COLOR_RESET}"
        exit 1
    fi

# Check for /usr/data/klipper directory
elif [ -d /usr/data/klipper ]; then
    echo -e "${COLOR_GREEN}Directory /usr/data/klipper exists.${COLOR_RESET}"
    pause
    echo -e "${COLOR_YELLOW}Deleting old firmware...${COLOR_RESET}"
    delete_files "/usr/data/klipper/fw/K1"
    echo -e "${COLOR_YELLOW}Patching Kernel...${COLOR_RESET}"
    # Add your kernel patching command here if needed
    pause
    echo -e "${COLOR_YELLOW}Downloading latest firmware...${COLOR_RESET}"
    FILE="/usr/data/klipper/fw/K1/$(basename $URL)"
    [ -f "$FILE" ] && rm "$FILE"  # Remove existing file if it exists
    if wget --no-check-certificate -P /usr/data/klipper/fw/K1/ $URL; then
        echo -e "${COLOR_YELLOW}Patching latest firmware...${COLOR_RESET}"
        # Add your firmware patching command here if needed
        pause
        echo -e "${COLOR_GREEN}Firmware update successful!${COLOR_RESET}"
    else
        echo -e "${COLOR_RED}wget failed with error code $?.${COLOR_RESET}"
        exit 1
    fi

else
    echo -e "${COLOR_RED}Neither /usr/share/klipper nor /usr/data/klipper directory exists.${COLOR_RESET}"
    exit 1
fi
