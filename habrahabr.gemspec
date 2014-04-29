# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'habrahabr/version'

Gem::Specification.new do |spec|
  spec.name          = "habrahabr"
  spec.version       = Habrahabr::VERSION
  spec.authors       = ["Mark Abramov"]
  spec.email         = ["markizko@gmail.com"]
  spec.description   = %q{Habrahabr client}
  spec.summary       = %q{Habrahabr client}
  spec.homepage      = ""
  spec.license       = "Public domain"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'hashie'
  spec.add_dependency 'faraday', '~> 0.8.0'
  spec.add_dependency 'faraday_middleware', '~> 0.8.0'
  spec.add_dependency 'hashie'
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec', '~> 2.11.0'
  spec.add_development_dependency 'webmock'

end
