# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'ci-go-nfo/version'

Gem::Specification.new do |gem|
  gem.name          = "ci-go-nfo"
  gem.authors       = ["AbhishekKr"]
  gem.email         = ["abhikumar163@gmail.com"]
  gem.description   = %q{A console utility to get information from your ThoughtWorks' Go Continuous Integration Server. Run '$ ci-go-nfo setup' to configure your access from console utility.}
  gem.summary       = %q{a console utility to get information from your ThoughtWorks' Go Continuous Integration Server}
  gem.homepage      = "https://github.com/abhishekkr/ci-go-nfo"

  gem.files         = `git ls-files`.split($\)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.version       = Ci::Go::Nfo::VERSION

  gem.executables   = %w( ci-go-nfo )

  gem.add_runtime_dependency 'xml-motor', '>= 0.1.6'
  gem.add_development_dependency 'xml-motor', '>= 0.1.6'
end
