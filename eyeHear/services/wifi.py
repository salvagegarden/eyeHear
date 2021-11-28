import logging
import subprocess
import time
from urllib.request import urlopen

import pywifi
from pywifi import const

from services.draw import displayRedText, displayText

wifi = pywifi.PyWiFi()
logger = logging.getLogger("eyeHear")

ifaces = wifi.interfaces()
wifi_iface = None
for i in ifaces:
    if i.name() == "wlan0":
        wifi_iface = i


def connect_to_wifi(ssid: str, passwd: str) -> bool:
    profile = pywifi.Profile()
    profile.ssid = ssid
    profile.auth = const.AUTH_ALG_OPEN
    profile.akm.append(const.AKM_TYPE_WPA2PSK)
    profile.cipher = const.CIPHER_TYPE_CCMP
    profile.key = passwd
    tmp_profile = wifi_iface.add_network_profile(profile)
    displayRedText(f"$ Connect {ssid}")
    wifi_iface.connect(tmp_profile)

    for _ in range(5):
        time.sleep(4)
        if wifi_iface.status() == const.IFACE_CONNECTED:
            displayRedText(f"$ Connected: {ssid}")
            time.sleep(5)
            return True
    return False


def detect_internet():
    try:
        urlopen("https://google.com", timeout=5)
    except Exception as err:
        logger.warning(f"Network error: {err}")
        return False
    else:
        cmd = "iwgetid -r"
        ssid = subprocess.check_output(cmd, shell=True).decode("utf-8")
        displayRedText(f"$ WiFi: {ssid}")
        return True
