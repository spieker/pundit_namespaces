# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pundit_namespaces/version'

Gem::Specification.new do |spec|
  spec.name          = "pundit_namespaces"
  spec.version       = PunditNamespaces::VERSION
  spec.authors       = ["Paul Spieker"]
  spec.email         = ["p.spieker@duenos.de"]

  spec.summary       = %q{Add namespacing support to Pundit}
  spec.homepage      = "https://github.com/spieker/pundit_namespaces"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "pundit", "~> 1.0"
  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "codeclimate-test-reporter"
end
