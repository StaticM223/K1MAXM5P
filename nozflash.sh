# Check for /usr/share/klipper directory
if [ -d /usr/share/klipper ]; then
    rm /usr/share/klipper/fw/K1/noz0_120_G30-noz0_003_000.bin
    wget --no-check-certificate -P /usr/share/klipper/fw/K1/ https://github.com/StaticM223/K1MAXM5P/raw/main/noz0_120_G30-noz0_014_000.bin

# Check for /usr/data/klipper directory
elif [ -d /usr/data/klipper ]; then
    rm /usr/data/klipper/fw/K1/noz0_120_G30-noz0_003_000.bin
    wget --no-check-certificate -P /usr/data/klipper/fw/K1/ https://github.com/StaticM223/K1MAXM5P/raw/main/noz0_120_G30-noz0_014_000.bin

else
    echo "Neither /usr/share/klipper nor /usr/data/klipper directory exists."
fi
