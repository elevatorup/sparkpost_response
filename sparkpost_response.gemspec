# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "sparkpost_response/version"

Gem::Specification.new do |spec|
  spec.name          = "sparkpost_response"
  spec.version       = SparkpostResponse::VERSION
  spec.authors       = ["George Karaszi"]
  spec.email         = ["georgekaraszi@gmail.com"]

  spec.required_ruby_version = ">= 2.0.0"
  spec.summary       = "Handles the Sparkpost API querying"
  spec.description   = "Handles the Sparkpost API querying"
  spec.homepage      = "https://github.com/elevatorup/sparkpost_response"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.5"
  spec.add_development_dependency "rubocop", "~> 0.43"
end
