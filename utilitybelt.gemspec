# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name        = "utilitybelt"
  s.version     = "1.0.0"

  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Joshua Mervine"]
  s.email       = ["jmervine@yp.com"]
  s.homepage    = "https://stash.int.yp.com/users/jmervine/repos/ruby-utilitybelt/browse"
  s.license     = 'n/a'

  s.summary     = "My Ruby Utils"
  s.description = s.summary

  s.add_runtime_dependency "omnistruct"
  s.add_development_dependency "minitest", "~> 5.4", ">= 5.4.3"

  s.files        = Dir.glob("*.rb") + %w(README.md)
  s.require_path = "."
end

