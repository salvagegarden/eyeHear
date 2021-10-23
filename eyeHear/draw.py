import textwrap
import time

import Adafruit_GPIO as GPIO
import Adafruit_GPIO.SPI as SPI
import numpy as np
from PIL import Image, ImageDraw, ImageFont

import ST7789 as TFT

# Raspberry Pi pin configuration:
RST = 25
DC = 24
LED = 27
SPI_PORT = 0
SPI_DEVICE = 0
SPI_MODE = 0b11
SPI_SPEED_HZ = 40000000


def expand2square(pil_img, background_color):
    width, height = pil_img.size
    if width == height:
        return pil_img
    elif width > height:
        result = Image.new(pil_img.mode, (width, width), background_color)
        result.paste(pil_img, (0, (width - height) // 2))
        return result
    else:
        result = Image.new(pil_img.mode, (height, height), background_color)
        result.paste(pil_img, ((height - width) // 2, 0))
        return result


display = TFT.ST7789(
    spi=SPI.SpiDev(SPI_PORT, SPI_DEVICE, max_speed_hz=SPI_SPEED_HZ),
    mode=SPI_MODE,
    rst=RST,
    dc=DC,
    led=LED,
)

# Initialize display.
display.begin()

# Clear display.
display.clear()

# Analogue clock setting
width = 240
height = 240
image = Image.new("RGB", (display.width, display.height), "BLACK")
draw = ImageDraw.Draw(image)

# font setting
# font = ImageFont.load_default()
font = ImageFont.truetype("/usr/share/fonts/truetype/dejavu/DejaVuSansMono.ttf", 20)
header_font = ImageFont.truetype(
    "/usr/share/fonts/truetype/dejavu/DejaVuSansMono.ttf", 22
)
header = header_font.getsize("0")[1] + 10
line_width = int(width / font.getsize("0")[0])
header_width = int(width / header_font.getsize("0")[0])


def draw_rotated_text(image, text, position, angle, font, fill=(255, 255, 255)):
    # print position
    position = position[0], position[1]
    # Get rendered font width and height.
    draw = ImageDraw.Draw(image)
    width, height = draw.textsize(text, font=font)
    # Create a new image with transparent background to store the text.
    textimage = Image.new("RGBA", (width, height), (0, 0, 0, 0))
    # Render the text.
    textdraw = ImageDraw.Draw(textimage)
    textdraw.text((0, 0), text, font=font, fill=fill)
    # Rotate the text image.
    rotated = textimage.rotate(angle, expand=1)
    # Paste the text into the image, using it as a mask for transparency.
    image.paste(rotated, position, rotated)


def displayRedText(oledText):
    # overlay text on top row before it goes green
    draw = ImageDraw.Draw(image)
    draw.rectangle((0, 0, display.width, header), outline=0, fill=0)

    draw.text((0, 0), oledText[-header_width:], font=header_font, fill=(220, 220, 0, 0))
    display.image(image)
    # display.show()
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
    lines = textwrap.wrap(oledText, width=line_width)
    for line in lines:
        draw.text((0, offset), line, font=font, fill=(0, 220, 255, 0))
        offset += font.getsize(line)[1]
    display.image(image)
    # display.show()
    time.sleep(0.1)
