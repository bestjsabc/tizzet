# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "babosa"
  s.version = "0.2.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Norman Clarke"]
  s.date = "2011-01-23"
  s.description = "    A library for creating slugs. Babosa an extraction and improvement of the\n    string code from FriendlyId, intended to help developers create similar\n    libraries or plugins.\n"
  s.email = "norman@njclarke.com"
  s.homepage = "http://norman.github.com/babosa"
  s.require_paths = ["lib"]
  s.rubyforge_project = "[none]"
  s.rubygems_version = "1.8.23"
  s.summary = "A library for creating slugs."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
