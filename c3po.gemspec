# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)
require 'c3po/version'

Gem::Specification.new do |s|
  s.name         = "c3po"
  s.version      = C3po::VERSION
  s.authors      = ["af83"]
  s.email        = "jboyer@af83.com"
  s.description  = "Ruby translation client"
  s.summary      = "Ruby translation client"
  s.files        = `git ls-files lib LICENSE README.md`.split("\n")
  s.platform     = Gem::Platform::RUBY
  s.require_path = 'lib'
  s.add_development_dependency "rspec", "~>2.6"
  s.add_dependency "typhoeus", "~>0.2.4"
  s.add_dependency "nokogiri", "~>1.5.0"
  s.add_dependency "yajl-ruby", "~>0.8.2"
end
