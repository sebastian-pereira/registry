# -*- encoding: utf-8 -*-
require 'rubygems'
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'My_Vk/version'

Gem::Specification.new do |gem|
  gem.name          = "My_Vk"
  gem.version       = MyVk::VERSION
  gem.authors       = ["Alex Letov"]
  gem.email         = ["aleksey.shkadov@mail.ru"]
  gem.description   = %q{Write a gem description}
  gem.summary       = %q{Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split("\n")
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

end
