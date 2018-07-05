# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'authlete/version'

Gem::Specification.new do |spec|
  spec.name          = "authlete"
  spec.version       = Authlete::VERSION
  spec.authors       = ["Takahiko Kawasaki"]
  spec.email         = ["taka@authlete.com"]
  spec.summary       = "A library for Authlete Web APIs"
  spec.description   = "A library for Authlete Web APIs. See https://docs.authlete.com/ for details."
  spec.homepage      = "https://www.authlete.com/"
  spec.license       = "Apache License, Version 2.0"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rest-client", ">= 1.7.2"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
