# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'biblio_refs/version'

Gem::Specification.new do |spec|
  spec.name          = "biblio-refs"
  spec.version       = BiblioRefs::VERSION
  spec.authors       = ["Sergio Rodríguez"]
  spec.email         = ["alu0100699968@ull.edu.es"]

  spec.summary       = %q{Gema para representar referencias bibliográficas.}
  spec.homepage      = "https://github.com/alu0100699968/biblio_refs"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"

  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "guard-bundler"

  spec.add_development_dependency "coveralls"
end
