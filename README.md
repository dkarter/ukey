## UKey

Automatically lock mac when a USB device is removed

## Installation

Install the gem globally:

```bash
gem install ukey
```

## Usage

Select the device by plugging it in and running:

```bash
ukey select-device
```

I use a YubiKey, which I prefer because you do not have to eject it, 
but this script will work with almost any USB device.

Then to run the program

```bash
ukey watch
```
