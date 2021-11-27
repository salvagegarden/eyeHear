import keyboard

from services.draw import displayRedText, displayText


def ask_wifi():
    displayRedText("$ Setup Wi-Fi? y/n")
    records = keyboard.record(until="enter")
    if "y" in list(keyboard.get_typed_strings(records))[0]:
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
    while True:
        e = keyboard.read_event()
        events.append(e)
        lines = list(keyboard.get_typed_strings(events))
        line = lines[0]
        displayText(f"> {line}")
        if len(lines) > 1:
            return line
