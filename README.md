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

## Menubar App

ukey works with BitBar - it will show you the status of the ukey watcher and allow you to start and stop the watcher right from your macOS menubar.

### Installation

1. Install the ukey gem globally (instructions above)
2. Install BitBar from [this fork by @oleander](https://github.com/oleander/bitbar/releases) 
3. Copy the bitbar/ukey.rb file from the ukey repo into your BitBar "enabled plugins" folder.
4. Run BitBar
