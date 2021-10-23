# EyeHear

A techForGood project to display speech-to-text on a wearable low-cost device.

## Get started

> This project requires python3, you may need to replace command `python` to `python3` and `pip` to `pip3`.

<details>
  <summary>Install Python</summary>
  
```bash
sudo apt-get update
sudo apt-get install -y build-essential python-dev python-rpi.gpio python-spidev python-pip python-pil python-numpy
```

</details>

<details>
  <summary>Install prerequisities</summary>

```bash
pip install -r requirements.txt
```

</details>

```bash
export GOOGLE_APPLICATION_CREDENTIALS="/home/pi/your_google_cloud_application_credential.json"

git clone https://github.com/salvagegarden/eyeHear.git
cd eyeHear
python eyeHear/main.py
```

## Hardware

<details>
  <summary>Raspberry Pi Zero</summary>

- 1GHz CPU
- 512MB RAM

</details>

<details>
  <summary>Display: SSD1306</summary>

- Resolution: 128x64

</details>

<details>
  <summary>Microphone</summary>

- USB Microphone

</details>
