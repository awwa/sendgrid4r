# coding: utf-8
src = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(src) unless $LOAD_PATH.include?(src)
require 'sendgrid4r/version'

Gem::Specification.new do |spec|
  spec.name          = 'sendgrid4r'
  spec.version       = SendGrid4r::VERSION
  spec.authors       = ['awwa500@gmail.com']
  spec.email         = ['awwa500@gmail.com']
  spec.summary       = 'SendGrid Web API v3 module'
  spec.description   = 'SendGrid Web API v3 module'
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency('rest-client', '>=1.8.0', '<1.9.0')
  spec.add_development_dependency('rubocop', '>=0.29.0', '<0.34.3')
  spec.add_development_dependency('bundler', '>=1.6.0', '<1.11.0')
  spec.add_development_dependency('rspec', '3.1.0')
  spec.add_development_dependency('dotenv', '>=0.11.0', '<0.12.0')
end
