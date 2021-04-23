# frozen_string_literal: true

# good

Gem::Specification.new do |spec|
  spec.required_ruby_version = '>= 2.2'
end

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'translateable_attributes/version'

Gem::Specification.new do |spec|
  spec.name          = 'translateable_attributes'
  spec.version       = TranslateableAttributes::VERSION
  spec.authors       = ['Toms Mikoss']
  spec.email         = ['toms.mikoss@gmail.com']

  spec.summary       = 'Helper methods to display translated values of object attributes.'
  spec.description   = 'Helper methods to display translated values of object attributes (stored in database, plain object properties, ...)'
  spec.homepage      = 'https://github.com/tmikoss/translateable_attributes'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activesupport', '>= 4'
  spec.add_runtime_dependency 'i18n'

  spec.add_development_dependency 'bundler', '~> 1.9'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '>= 3.3.0'
  spec.add_development_dependency 'rubocop'
end
