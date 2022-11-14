# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'transifex/version'

Gem::Specification.new do |s|
  s.version       = Transifex::VERSION
  s.name          = 'transifex-ruby'
  s.license       = 'MIT'
  s.homepage      = 'http://github.com/tmaesaka/transifex-ruby'
  s.summary       = 'Ruby client library for Transifex API'
  s.description   = s.summary

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']
  s.authors       = ['Toru Maesaka', 'Jason Barnabe']
  s.email         = ['toru@tmaesaka.com', 'jason.barnabe@gmail.com']

  s.add_dependency 'faraday', '> 1.0.0', '< 2.0.0'

  # Required for faraday-rashify
  s.add_dependency 'rash_alt'

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'webmock'
  s.add_development_dependency 'pry'
end
