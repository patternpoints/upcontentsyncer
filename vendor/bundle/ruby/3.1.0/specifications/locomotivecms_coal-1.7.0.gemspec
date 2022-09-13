# -*- encoding: utf-8 -*-
# stub: locomotivecms_coal 1.7.0 ruby lib

Gem::Specification.new do |s|
  s.name = "locomotivecms_coal".freeze
  s.version = "1.7.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Didier Lafforgue".freeze]
  s.date = "2021-09-07"
  s.description = "The LocomotiveCMS Coal is the API ruby client for the LocomotiveCMS platform".freeze
  s.email = ["didier@nocoffee.fr".freeze]
  s.homepage = "https://github.com/locomotivecms/coal".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0".freeze)
  s.rubygems_version = "3.3.3".freeze
  s.summary = "The LocomotiveCMS Coal is the API ruby client for the LocomotiveCMS platform".freeze

  s.installed_by_version = "3.3.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<rake>.freeze, ["~> 13.0.1"])
    s.add_runtime_dependency(%q<httpclient>.freeze, ["~> 2.8.3"])
    s.add_runtime_dependency(%q<faraday>.freeze, ["~> 0.17"])
    s.add_runtime_dependency(%q<faraday_middleware>.freeze, ["~> 0.13.1"])
    s.add_runtime_dependency(%q<activesupport>.freeze, [">= 5.1.5", "< 6.1"])
    s.add_runtime_dependency(%q<mime-types>.freeze, ["~> 3.3.0"])
  else
    s.add_dependency(%q<rake>.freeze, ["~> 13.0.1"])
    s.add_dependency(%q<httpclient>.freeze, ["~> 2.8.3"])
    s.add_dependency(%q<faraday>.freeze, ["~> 0.17"])
    s.add_dependency(%q<faraday_middleware>.freeze, ["~> 0.13.1"])
    s.add_dependency(%q<activesupport>.freeze, [">= 5.1.5", "< 6.1"])
    s.add_dependency(%q<mime-types>.freeze, ["~> 3.3.0"])
  end
end
