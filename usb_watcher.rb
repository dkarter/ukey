require 'libusb'

class UsbWatcher
  def initialize
    loop do
      sleep(interval * 2) if screen_locked?
      lock_screen if device_removed?
      sleep(interval)
    end
  end

  private

  def usb
    @usb ||= LIBUSB::Context.new
  end

  def device_removed?
    usb.devices.map(&:product).none? { |p| p.match(device_name) }
  end

  def device_name
    'Yubikey'
  end

  def interval
    5
  end

  def screen_locked?
    cmd = 'import sys,Quartz; d=Quartz.CGSessionCopyCurrentDictionary(); sys.exit(d and d.get("CGSSessionScreenIsLocked", 0) == 0 and d.get("kCGSSessionOnConsoleKey", 0) == 1)'
    system("python -c '#{cmd}'")
  end

  def lock_screen
    cmd = '/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'
    system(cmd)
  end
end

UsbWatcher.new
