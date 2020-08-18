lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'time_cursor/version'

Gem::Specification.new do |spec|
  spec.name          = "time_cursor"
  spec.version       = TimeCursor::VERSION
  spec.authors       = ["arimay"]
  spec.email         = ["arima.yasuhiro@gmail.com"]

  spec.summary       = %q{ Get the datetime for event schedule. }
  spec.description   = %q{ Get the next or previous datetime along the rules that are given in a crontab-like format or other options. }
  spec.homepage      = "https://github.com/arimay/time_cursor/"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
