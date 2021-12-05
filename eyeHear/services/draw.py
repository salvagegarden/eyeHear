import textwrap
import time

import Adafruit_GPIO as GPIO
import Adafruit_GPIO.SPI as SPI
import numpy as np
import ST7789 as TFT
from PIL import Image, ImageDraw, ImageFont

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
font = ImageFont.truetype("/usr/share/fonts/truetype/dejavu/DejaVuSansMono.ttf", 18)
header_font = ImageFont.truetype(
    "/usr/share/fonts/truetype/dejavu/DejaVuSansMono.ttf", 20
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


text_buffer = ["$ EyeHear starting"]


def displayRedText(oledText, new_line=True):
    if new_line:
        text_buffer.append(oledText)
    else:
        text_buffer[-1] = oledText
    return draw_text_buffer((220, 220, 0, 0))
    # overlay text on top row before it goes green
    draw = ImageDraw.Draw(image)
    draw.rectangle((0, 0, display.width, header), outline=0, fill=0)

    text = oledText.strip()
    draw.text((0, 0), text[-header_width:], font=header_font, fill=(220, 220, 0, 0))
    display.image(image)
    # display.show()
    # print("~") #debug oled
    time.sleep(0.1)


def displayText(oledText):
    text_buffer[-1] = oledText
    return draw_text_buffer()
    # image = Image.new("1", (display.width, display.height))
    global header
    draw = ImageDraw.Draw(image)
    # fill empty recntangle to clear the screen
    draw.rectangle(
        (0, header, display.width - 1, display.height - 1), outline=1, fill=0
    )
    offset = header
    lines = textwrap.wrap(oledText.strip(), width=line_width)
    for line in lines:
        draw.text((0, offset), line, font=font, fill=(0, 220, 255, 0))
        offset += font.getsize(line)[1]
    display.image(image)
    # display.show()
    time.sleep(0.1)


max_line = int(240 / font.getsize("0")[1]) - 2
print("Max lines:", max_line)


def parse_text_to_lines():
    all_lines = []
    for text in reversed(text_buffer):
        lines = textwrap.wrap(text.strip(), width=line_width)
        for line in reversed(lines):
            all_lines.append(line)
            if len(all_lines) >= max_line:
                return all_lines[:max_line]
    return all_lines


def draw_text_buffer(color=None):
    default_color = (0, 180, 195, 0)
    if color is None:
        color = default_color
    draw = ImageDraw.Draw(image)
    draw.rectangle((0, 0, display.width, display.height), fill=0)

    all_lines = parse_text_to_lines()
    offset = 0
    for line in reversed(all_lines[1:]):
        draw.text((0, offset), line, font=font, fill=default_color)
        offset += font.getsize(line)[1]

    offset += 1
    draw.rectangle(
        (0, offset, display.width - 2, offset + font.getsize(all_lines[0])[1] + 2),
        outline=(0, 200, 222, 0),
    )
    draw.text((1, offset + 1), all_lines[0], font=font, fill=color)
    display.image(image)
