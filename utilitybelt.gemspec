# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name        = "utilitybelt"
  s.version     = "1.0.0-1"

  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Joshua Mervine"]
  s.email       = ["joshua@mervine.net"]
  s.homepage    = "https://github.com/jmervine/ruby-utilitybelt"
  s.license     = 'n/a'

  s.summary     = "My Ruby Utility Belt"
  s.description = s.summary + " -- Not really intended for general use, but you're welcome to it."

  s.add_runtime_dependency "omnistruct"
  s.add_development_dependency "minitest", "~> 5.4", ">= 5.4.3"

  s.files        = Dir.glob("*.rb") + %w(README.md)
  s.require_path = "."
end
