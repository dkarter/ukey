# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ukey/version"

Gem::Specification.new do |spec|
  spec.name          = "ukey"
  spec.version       = Ukey::VERSION
  spec.authors       = ["Dorian Karter"]
  spec.email         = ["jobs@doriankarter.com"]

  spec.summary       = 'Watches for USB devices - when removed locks macOS'
  spec.description   = 'A CLI for detecting a USB device removal and locking macOS'
  spec.homepage      = 'https://doriankarter.com'
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'libusb', '~> 0.6.3'
  spec.add_dependency 'thor', '~> 0.20.0'
  spec.add_dependency 'highline', '~> 1.7.8'

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'pry'
end
