# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'authlete/version'

Gem::Specification.new do |spec|
  spec.name          = "authlete"
  spec.version       = Authlete::VERSION
  spec.authors       = ["Takahiko Kawasaki", "Hideki Ikeda", "Seth Wright"]
  spec.email         = ["admin@authlete.com"]
  spec.summary       = "A library for Authlete Web APIs"
  spec.description   = "A library for Authlete Web APIs. See https://docs.authlete.com/ for details."
  spec.homepage      = "https://www.authlete.com/"
  spec.license       = "Apache License, Version 2.0"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.start_with?("test/") }
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rest-client", ">= 1.7.2"

  spec.add_development_dependency "bundler", ">= 2.2.10"
  spec.add_development_dependency "rake", ">= 12.3.3"
end
