import threading
import time

import keyboard

from services.draw import displayRedText, displayText


def ask_wifi():
    displayRedText("$ Setup Wi-Fi? y/n")
    records = keyboard.record(until="enter")
    if "y" in list(keyboard.get_typed_strings(records))[-1]:
        displayRedText("Wi-Fi SSID: ")
        displayRedText("> ")
        ssid = input_line()
        displayRedText("Password: ")
        displayRedText("> ")
        passwd = input_line()
        return ssid, passwd
    else:
        displayRedText("$ Skipped")
        return None


def input_line():
    events = []

    def record() -> list:
        while True:
            e = keyboard.read_event()
            events.append(e)
            if e.name == "enter":
                break

    t = threading.Thread(record)
    t.start()

    while True:
        time.sleep(0.5)
        lines = list(keyboard.get_typed_strings(events))
        line = lines[0]
        displayText(f"> {line}")
        if len(lines) > 1:
            return line
