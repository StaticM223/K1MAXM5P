FILE1="noz0_120_G30-noz0_007_000.bin"
FILE2="noz0_120_G30-noz0_009_000.bin"  # Alternative file to try if FILE1 is not found
URL1="https://github.com/StaticM223/K1MAXM5P/raw/main/noz0_120_G30-noz0_014_000.bin"

# Check for /usr/share/klipper directory
if [ -d /usr/share/klipper ]; then
    if [ -f /usr/share/klipper/fw/K1/$FILE1 ]; then
        rm /usr/share/klipper/fw/K1/$FILE1
    elif [ -f /usr/share/klipper/fw/K1/$FILE2 ]; then
        rm /usr/share/klipper/fw/K1/$FILE2
    fi
    wget --no-check-certificate -P /usr/share/klipper/fw/K1/ $URL1

# Check for /usr/data/klipper directory
elif [ -d /usr/data/klipper ]; then
    if [ -f /usr/data/klipper/fw/K1/$FILE1 ]; then
        rm /usr/data/klipper/fw/K1/$FILE1
    elif [ -f /usr/data/klipper/fw/K1/$FILE2 ]; then
        rm /usr/data/klipper/fw/K1/$FILE2
    fi
    wget --no-check-certificate -P /usr/data/klipper/fw/K1/ $URL1

else
    echo "Klipper isnt installed! you must install it first or reset your printer and restart the install from step #1"
fi















