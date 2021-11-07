#!/bin/bash

cd /home/pi

sudo apt-get update
sudo apt-get install -y build-essential python-dev python-rpi.gpio python-spidev python-pip python-pil python-numpy raspberrypi-kernel-headers
pip3 install google-cloud-speech==2.9.3 PyAudio==0.2.11 Adafruit-GPIO==1.0.3

git clone https://github.com/salvagegarden/eyeHear.git

crontab -l | { cat; echo '@reboot GOOGLE_APPLICATION_CREDENTIALS="/home/pi/engineering-good-1569744069426-f14580c084fd.json" python3 /home/pi/eyeHear/eyeHear/main.py  >> /home/pi/eyeHear.log 2>&1'; } | crontab -

# Setup i2smic driver
sudo pip3 install adafruit-python-shell
wget https://raw.githubusercontent.com/adafruit/Raspberry-Pi-Installer-Scripts/master/i2smic.py
sudo python3 i2smic.py
