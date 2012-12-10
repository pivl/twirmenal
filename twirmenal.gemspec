# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'twirmenal/version'

Gem::Specification.new do |gem|
  gem.name          = "twirmenal"
  gem.version       = Twirmenal::VERSION
  gem.authors       = ["Pavel Stasyuk"]
  gem.email         = ['pivlyak@gmail.com']
  gem.description   = %q{Twirmenal, a twitter terminal}
  gem.summary       = %q{Twirmenal, a twitter terminal}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = ["twirmenal"]
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_dependency('oauth', '> 0.4.0')
end
