## UKey

Automatically lock mac when a USB device is removed

## Install

Clone the git repo:

```bash
git clone https://github.com/dkarter/ukey
```

cd into the ukey directory and run `bundle install`

Then to run the program

```bash
ukey watch
```

## Customize
You can change the device by plugging it in and running:

`ukey select-device`

I use a YubiKey, which I prefer because you do not have to eject it, 
but this script will work with almost any USB device.
