# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'minedig/version'

Gem::Specification.new do |spec|
  spec.name          = "minedig"
  spec.version       = Minedig::VERSION
  spec.authors       = ["siman"]
  spec.email         = ["shuichi@occ.co.jp"]
  spec.summary       = %q{Redmine API wrapper}
  spec.description   = %q{Redmine API wrapper}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "dotenv"
  spec.add_development_dependency "rake"
end
