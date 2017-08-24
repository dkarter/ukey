# frozen_string_literal: true

require 'libusb'

module Ukey
  # Watches usb devices and locks screen if removed
  class UsbWatcher
    def initialize(device_name:, interval: 5)
      @device_name = device_name
      @interval = interval
      @usb = LIBUSB::Context.new
    end

    def watch
      loop do
        sleep(interval * 2) if screen_locked?
        lock_screen if device_removed?
        sleep(interval)
      end
    rescue SystemExit, Interrupt, KeyboardInterrupt
      puts "\nWatcher terminated."
    end

    def list_devices
      usb.devices.map(&:product)
    end

    private

    attr_reader :interval, :device_name, :usb

    def device_removed?
      list_devices.none? { |p| p == device_name }
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
end
