# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "more_view_hooks/version"
require "more_view_hooks/infos"

Gem::Specification.new do |spec|
  spec.name          = "redmine-more_view_hooks"
  spec.version       = MoreViewHooks::VERSION
  spec.authors       = MoreViewHooks::Infos::AUTHORS.keys
  spec.email         = MoreViewHooks::Infos::AUTHORS.values
  spec.summary       = MoreViewHooks::Infos::DESCRIPTION
  spec.description   = MoreViewHooks::Infos::DESCRIPTION
  spec.homepage      = MoreViewHooks::Infos::URL
  spec.license       = MoreViewHooks::Infos::LICENSE

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", "~> 4.2.0"
  spec.add_dependency "deface", "~> 1.2.0"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rubocop"
end
