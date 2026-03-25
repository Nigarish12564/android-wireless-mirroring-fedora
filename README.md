Fedora Android Wireless Mirroring Setup 

This repository provides a beginner-friendly Bash script that helps you set up ADB and Scrcpy on Fedora Linux from scratch. 

The goal is simple: 
instead of manually troubleshooting package conflicts, downloading files, extracting archives, enabling wireless debugging, and launching Scrcpy with custom options every time — you can run one script and follow a few prompts. 

What this script does 

    Installs ADB (android-tools)  

    Handles the Fedora ffmpeg dependency conflict  

    Downloads Scrcpy v3.3.4  

    Extracts and prepares the Scrcpy files  

    Detects a phone connected via USB  

    Switches ADB to wireless TCP/IP mode  

    Connects your phone using its IP address  

    Launches Scrcpy with:  

    custom video bitrate  

    custom max resolution  

Who is this for? 

This is useful for: 

    Fedora users who want to use Scrcpy wirelessly  

    Beginners who don’t want to manually set up every step  

    Anyone who wants a repeatable setup process to share with friends  

Requirements 

Before running the script, make sure: 

    You are using Fedora Linux  

    Your Android phone has:  

    Developer Options enabled  

    USB Debugging enabled  

    Your phone and laptop are on the same Wi-Fi network  

    You connect your phone via USB first for the initial setup  

Why this exists 

Setting up Scrcpy on Fedora can sometimes be annoying because: 

    scrcpy may not be available directly in repositories  

    Fedora may have package conflicts (ffmpeg-free vs ffmpeg)  

    wireless ADB setup can feel confusing for first-time users  

This script automates the parts that can be automated and guides the user through the parts that require manual confirmation. 
