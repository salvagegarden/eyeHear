#!/usr/bin/env python
import logging
import math
import struct
import subprocess
import time
from urllib.request import urlopen

import google
import pyaudio

from draw import displayRedText, displayText
from service import (
    CHUNK_SIZE,
    DEVICE_INDEX,
    PA_CHANNELS,
    PA_FORMAT,
    SAMPLE_RATE,
    parse_to_int16,
    speech_regonize,
)

logging.basicConfig(
    level=logging.INFO,
    format="[%(asctime)s] %(levelname)s - %(message)s",
    datefmt="%H:%M:%S",
)
logger = logging.getLogger("eyeHear")


def detect_volume():
    def rms(data):
        count = len(data) / 2
        v_format = f"{int(count)}h"
        shorts = struct.unpack(v_format, data)
        sum_squares = 0.0
        for sample in shorts:
            n = sample * (1.0 / 32768)
            sum_squares += n * n
        return math.sqrt(sum_squares / count)

    p = pyaudio.PyAudio()
    stream = p.open(
        format=PA_FORMAT,
        input_device_index=DEVICE_INDEX,
        channels=PA_CHANNELS,
        rate=SAMPLE_RATE,
        input=True,
        frames_per_buffer=CHUNK_SIZE,
    )

    for _ in range(5):
        stream.read(CHUNK_SIZE)
    while True:
        data = parse_to_int16(stream.read(CHUNK_SIZE))
        result = rms(data)
        # print("RMS: ", result)
        if result > 0.04:
            break
    stream.close()


def detect_internet():
    try:
        urlopen("https://google.com", timeout=5)
        return True
    except Exception as err:
        logger.warning(f"Network error: {err}")
        return False


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


def main():
    logger.info(f"Detecting network...")
    displayRedText("Detecting connection...")

    retry = 20
    while retry > 0:
        has_connection = detect_internet()
        if has_connection:
            break
        else:
            displayText(f"Connection failed, retry {retry}")
            time.sleep(2)
        retry -= 1

    # Get current IP address
    cmd = "hostname -I | cut -d' ' -f1"
    IP = subprocess.check_output(cmd, shell=True).decode("utf-8")
    while True:
        displayRedText(f"IP: {IP}")
        displayRedText("Waiting to start...")
        detect_volume()
        stream_loop()


if __name__ == "__main__":
    main()
