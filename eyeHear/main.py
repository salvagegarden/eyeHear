#!/usr/bin/env python
import logging
import os
import subprocess
import time

import google
import keyboard

from services.draw import displayRedText, displayText
from services.interaction import ask_wifi
from services.sound import detect_volume
from services.speech import speech_regonize
from services.wifi import connect_to_wifi, detect_internet

os.environ[
    "GOOGLE_APPLICATION_CREDENTIALS"
] = "/home/pi/engineering-good-1569744069426-f14580c084fd.json"
logging.basicConfig(
    level=logging.INFO,
    format="[%(asctime)s] %(levelname)s - %(message)s",
    datefmt="%H:%M:%S",
)
logger = logging.getLogger("eyeHear")


def stream_loop():
    while True:
        try:
            speech_regonize()
        except google.api_core.exceptions.OutOfRange as err:
            logger.error(err)
            displayRedText("Too long silence")
            displayText("Terminating eyeHear...")
            break
        except google.api_core.exceptions.ServerError as err:
            logger.error(err)
            displayRedText("Error: server error")
            displayText(str(err))
        except Exception as err:
            logger.error(err)
            displayRedText("Error")
            displayText(str(err))
        else:
            displayRedText("Exit")
            displayText("Exiting")
            time.sleep(3)
            break
        time.sleep(10)
        displayText("Going to reconnect service...")
        time.sleep(3)


def setup_wifi():
    ssid = ""
    password = ""

    def func(key):
        global ssid
        if key.name == "enter":
            return
        else:
            ssid += key.name

    keyboard.on_press(func)
    displayText("SSID:", ssid)
    while True:
        time.sleep(0.1)


def main():
    logger.info(f"Detecting network...")
    displayRedText("$ Connecting Wi-Fi...")

    retry = 15
    while retry > 0:
        has_connection = detect_internet()
        if has_connection:
            break
        else:
            displayText(f"$ Connection failed, retry {retry}")
            time.sleep(1)
        retry -= 1

    is_connected = has_connection
    while is_connected is False:
        wifi_config = ask_wifi()
        if wifi_config is not None:
            is_connected = connect_to_wifi(wifi_config[0], wifi_config[1])
        else:
            break

    # Get current IP address
    cmd = "hostname -I | cut -d' ' -f1"
    IP = subprocess.check_output(cmd, shell=True).decode("utf-8")
    while True:
        displayRedText(f"$ IP: {IP}")
        displayRedText("$ Waiting to start...")
        detect_volume()
        stream_loop()


if __name__ == "__main__":
    main()
