# -*- encoding: utf-8 -*-
require File.expand_path('../lib/omniauth-kindful/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Ty DeLong"]
  gem.email         = ["ty@kindful.com"]
  gem.description   = %q{OmniAuth strategy for Kindful.}
  gem.summary       = %q{OmniAuth strategy for Kindful.}
  gem.homepage      = "https://github.com/Kindful/omniauth-kindful"
  gem.license       = "MIT"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "omniauth-kindful"
  gem.require_paths = ["lib"]
  gem.version       = OmniAuth::Kindful::VERSION

  gem.add_dependency 'omniauth', '~> 1.0'
  gem.add_dependency 'omniauth-oauth2', '>= 1.1.1', '< 2.0'
  gem.add_development_dependency 'rspec', '~> 2.7'
  gem.add_development_dependency 'rack-test'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'webmock'
end
