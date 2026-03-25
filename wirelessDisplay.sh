#!/bin/bash

set -e

SCRCPY_VERSION="3.3.4"
SCRCPY_FILE="scrcpy-linux-x86_64-v${SCRCPY_VERSION}.tar.gz"
SCRCPY_DIR="$HOME/Downloads/scrcpy-linux-x86_64-v${SCRCPY_VERSION}"
SCRCPY_URL="https://github.com/Genymobile/scrcpy/releases/download/v${SCRCPY_VERSION}/${SCRCPY_FILE}"

echo "========================================"
echo " Scrcpy Wireless Setup for Fedora"
echo "========================================"
echo ""

# -----------------------------
# 1) Install dependencies
# -----------------------------
echo "[1/6] Installing ADB and required packages..."
sudo dnf install -y android-tools ffmpeg --allowerasing

echo ""
echo "Dependencies installed."
echo ""

# -----------------------------
# 2) Check USB phone connection
# -----------------------------
echo "[2/6] Connect your phone with a USB cable NOW."
echo "On your phone:"
echo "  - Turn ON Developer Options"
echo "  - Turn ON USB Debugging"
echo "  - Select USB mode: File Transfer / MTP"
echo "  - Tap 'Allow USB debugging' if prompted"
echo ""
read -p "Press Enter once your phone is connected and ready..."

adb devices

echo ""
echo "If you do NOT see your phone listed above as 'device',"
echo "fix the phone connection first, then run this script again."
echo ""
read -p "Do you see your phone listed as 'device'? (y/n): " DEVICE_OK

if [[ "$DEVICE_OK" != "y" && "$DEVICE_OK" != "Y" ]]; then
    echo "Phone not detected. Exiting."
    exit 1
fi

# -----------------------------
# 3) Download scrcpy if missing
# -----------------------------
echo ""
echo "[3/6] Downloading Scrcpy if needed..."

mkdir -p "$HOME/Downloads"

if [[ ! -f "$HOME/Downloads/$SCRCPY_FILE" ]]; then
    echo "Downloading $SCRCPY_FILE ..."
    wget -O "$HOME/Downloads/$SCRCPY_FILE" "$SCRCPY_URL"
else
    echo "Scrcpy archive already exists in Downloads."
fi

# -----------------------------
# 4) Extract and make executable
# -----------------------------
echo ""
echo "[4/6] Extracting Scrcpy and making it executable..."

if [[ ! -d "$SCRCPY_DIR" ]]; then
    tar -xvf "$HOME/Downloads/$SCRCPY_FILE" -C "$HOME/Downloads"
else
    echo "Scrcpy folder already extracted."
fi

chmod +x "$SCRCPY_DIR/scrcpy"
chmod +x "$SCRCPY_DIR/adb"

echo "Scrcpy is ready at:"
echo "  $SCRCPY_DIR"
echo ""

# -----------------------------
# 5) Enable wireless ADB
# -----------------------------
echo "[5/6] Enabling wireless ADB..."
cd "$SCRCPY_DIR"

./adb tcpip 5555

echo ""
echo "Now find your phone IP address:"
echo "  Settings -> Connections -> Wi-Fi -> your network -> IP address"
echo ""
read -p "Enter your phone IP address (example: 192.168.1.100): " PHONE_IP

echo "Connecting to $PHONE_IP:5555 ..."
./adb connect "$PHONE_IP:5555"

# -----------------------------
# 6) Ask for display settings and launch
# -----------------------------
echo ""
echo "[6/6] Launching Scrcpy..."
read -p "Enter video bit rate (example: 4M, 2M, 8M): " BITRATE
read -p "Enter max size (example: 1080, 720, 1440): " MAXSIZE

echo ""
echo "Starting Scrcpy wirelessly..."
./scrcpy --video-bit-rate "$BITRATE" --max-size "$MAXSIZE"

