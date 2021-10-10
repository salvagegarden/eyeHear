# EyeHear

A techForGood project to display speech-to-text on a wearable low-cost device.

## Get started

<details>
  <summary>Install Python</summary>
  ```bash
  sudo apt-get install build-essential python-dev python-pip
  ```
</details>

<details>
  <summary>Install prerequisities</summary>
  ```bash
  pip install -i requirements.txt
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
  1. 1GHz CPU
  2. 512MB RAM
</details>

<details>
  <summary>Display: SSD1306</summary>
  1. Resolution: 128x64
</details>

<details>
  <summary>Microphone</summary>
  1. USB Microphone
</details>
