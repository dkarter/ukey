# frozen_string_literal: true

require 'yaml'
require 'fileutils'

module Ukey
  # reads and writes the configuration for ukey
  module Config
    class << self
      def load_config
        return {} unless File.exist?(config_path)
        YAML.load_file(config_path) || {}
      end

      def device=(device_name)
        config = load_config.merge(device: device_name)
        write_config(config)
      end

      def device
        load_config[:device] || raise('Device not set.')
      end

      def interval=(interval)
        config = load_config.merge(interval: interval.to_i)
        write_config(config)
      end

      def interval
        (load_config[:interval] || 5).to_i
      end

      def write_config(config)
        FileUtils.mkdir_p(config_directory)
        File.open(config_path, 'w') { |f| YAML.dump(config, f) }
      end

      def config_path
        File.join(config_directory, 'ukey.yml')
      end

      def config_directory
        File.expand_path('~/.config/ukey')
      end
    end
  end
end
