# -*- encoding: utf-8 -*-
require File.expand_path('../lib/update_or_create/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Kurt Preston"]
  gem.email         = ["github@kurtpreston.com"]
  gem.description   = "Adds update_or_create method to ActiveRecord objects"
  gem.homepage      = "https://github.com/KurtPreston/update_or_create"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "update_or_create"
  gem.require_paths = ["lib"]
  gem.version       = UpdateOrCreate::VERSION
  gem.add_dependency "activerecord", ">= 3.1"
  gem.add_development_dependency "rspec", ">= 2.0"
  gem.add_development_dependency "activerecord", "~> 4.0.0"
  gem.add_development_dependency "sqlite3-ruby"
end

