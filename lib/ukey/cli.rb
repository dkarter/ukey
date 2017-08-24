# frozen_string_literal: true

require 'thor'
require 'highline/import'

module Ukey
  # Command line interface for ukey
  class CLI < Thor
    desc 'watch', 'Watches for USB device - locks screen if removed'
    def watch
      puts 'Watching...'
      watcher = UsbWatcher.new(device_name: Config.device)
      watcher.watch
    end

    desc 'select_device', 'Show all connected devices and allows selecting one'
    def select_device
      watcher = UsbWatcher.new
      devices = watcher.list_devices
      choose do |menu|
        menu.prompt = "Select a device (1-#{devices.count}):"
        devices.each do |dev|
          menu.choice(dev, &method(:device_selected))
        end
      end
    end

    private

    def device_selected(device)
      Config.device = device
      say("#{device} selected. Config written.")
    end
  end
end
