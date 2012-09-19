# -*- encoding: utf-8 -*-
require File.expand_path('../lib/ci-go-nfo/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["AbhishekKr"]
  gem.email         = ["abhikumar163@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "ci-go-nfo"
  gem.require_paths = ["lib"]
  gem.version       = Ci::Go::Nfo::VERSION

  gem.add_runtime_dependency 'xml-motor', '>= 0.1.6'
  gem.add_development_dependency 'xml-motor', '>= 0.1.6'
end
