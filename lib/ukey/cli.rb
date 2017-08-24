# frozen_string_literal: true

require 'thor'
require 'highline/import'

module Ukey
  # Command line interface for ukey
  class CLI < Thor
    desc 'watch', 'Watches for USB device - locks screen if removed'
    def watch
      puts 'Watching...'
      interval = Config.interval
      device = Config.device
      watcher = UsbWatcher.new(device_name: device, interval: interval)
      watcher.watch
    end

    desc 'select_device [device]', <<~DESC
    Show all connected devices and allows selecting one (if run without first
    argument)
    DESC
    def select_device(device = nil)
      return device_selected(device) if device
      watcher = UsbWatcher.new
      devices = watcher.list_devices
      choose do |menu|
        menu.prompt = "Select a device (1-#{devices.count}):"
        devices.each do |dev|
          menu.choice(dev, &method(:device_selected))
        end
      end
    end

    desc 'select_interval [interval (sec)]', <<~DESC
    Sets interval for checking if USB device removed
    DESC
    def select_interval(interval = nil)
      interval = HighLine.ask('Enter interval (sec):', Integer) unless interval
      interval_selected(interval)
    end

    private

    def device_selected(device)
      Config.device = device
      say(green("#{device} selected. Config written."))
    end

    def interval_selected(interval)
      Config.interval = interval
      say(green("#{interval}s interval selected. Config written."))
    end

    def green(msg)
      HighLine.color(msg, :green, :bold)
    end
  end
end
