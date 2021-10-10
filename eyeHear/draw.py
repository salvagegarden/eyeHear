import textwrap
import time

# Import the SSD1306 module.
import adafruit_ssd1306
import busio
# Import all board pins.
from board import SCL, SDA

##Saad salvage.garden 16sep: added OLED display support
##Saad last update: 19sep - displayText for SST transcription output

# SPDX-FileCopyrightText: Tony DiCola
# SPDX-License-Identifier: CC0-1.0

# Basic example of clearing and drawing pixels on a SSD1306 OLED display.
# This example and library is meant to work with Adafruit CircuitPython API.


# Create the I2C interface.
i2c = busio.I2C(SCL, SDA)

from PIL import Image, ImageDraw, ImageFont

# Setting some variables for our reset pin etc.
# RESET_PIN = digitalio.DigitalInOut(board.D4)
# Very important... This lets py-gaugette 'know' what pins to use in order to reset the display

# Create the SSD1306 OLED class.
# The first two parameters are the pixel width and pixel height.  Change these
# to the right size for your display!
display = adafruit_ssd1306.SSD1306_I2C(128, 32, i2c)
# Alternatively you can change the I2C address of the device with an addr parameter:
# display = adafruit_ssd1306.SSD1306_I2C(128, 32, i2c, addr=0x31)

# Clear the display.  Always call show after changing pixels to make the display
# update visible!
display.fill(0)
display.show()

# Audio recording parameters
STREAMING_LIMIT = 240000  # 4 minutes
SAMPLE_RATE = 16000
CHUNK_SIZE = int(SAMPLE_RATE / 10)  # 100ms

RED = "\033[0;31m"
GREEN = "\033[0;32m"
YELLOW = "\033[0;33m"
SPINNER = ["⠁", "⠂", "⠄", "⡀", "⢀", "⠠", "⠐", "⠈"]  # listener indicator = 8 frames
x = 0

# OLED Display INIT

# Create blank image for drawing.
image = Image.new("1", (display.width, display.height))
draw = ImageDraw.Draw(image)

# Load a font in 2 different sizes.
font = ImageFont.truetype(
    "/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf", 8
)  # size 10 gives us 26 characters per screen
tinyFont = ImageFont.truetype(
    "/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf", 8
)  # size 8 gives us 30 characters per screen

header = 10  # space for the first row / status bar / yellow region of OLED

print("OLED Display test")
display.fill(0)
w_delta = display.width / 10
h_delta = display.height / 10
for i in range(4):
    display.rect(0, 0, int(w_delta * i), int(h_delta * i), 1)
display.show()
time.sleep(0.1)


print("OLED Display text test")
try:
    # Clear display.
    display.fill(0)
    display.show()

    # Draw the text
    draw.text((0, 0), "Display activated!", font=tinyFont, fill=255)
    display.image(image)
    display.show()
except Exception as e:
    print("Display test failed ")
    for i in range(11):
        display.rect(0, 0, int(w_delta * i), int(h_delta * i), 1)
    display.show()
    print(e)

time.sleep(0.1)

def displayRedText(oledText):
    # overlay text on top row before it goes green
    draw = ImageDraw.Draw(image)
    draw.rectangle((0, 0, display.width, header), outline=0, fill=0)

    draw.text((0, 0), oledText[-30:], font=tinyFont, fill=255)
    display.image(image)
    display.show()
    # print("~") #debug oled
    time.sleep(0.1)


def displayText(oledText):
    # image = Image.new("1", (display.width, display.height))
    global header
    draw = ImageDraw.Draw(image)
    # fill empty recntangle to clear the screen
    draw.rectangle(
        (0, header, display.width - 1, display.height - 1), outline=1, fill=0
    )
    offset = header
    lines = textwrap.wrap(oledText, width=30)
    for line in lines:
        draw.text((0, offset), line, font=font, fill=255)
        offset += font.getsize(line)[1]
    display.image(image)
    display.show()
    time.sleep(0.1)
