# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tree_outline/version'

Gem::Specification.new do |spec|
  spec.name          = "tree_outline"
  spec.version       = TreeOutline::VERSION
  spec.authors       = ["flower-pot"]
  spec.email         = ["fbranczyk@gmail.com"]

  spec.summary       = "Stringifying trees"
  spec.description   = "Stringify trees in a fashion similar the output known from the unix tool 'tree'"
  spec.homepage      = "https://github.com/flower-pot/tree_outline"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'codeclimate-test-reporter'
end
