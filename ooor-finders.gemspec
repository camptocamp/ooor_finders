lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)
require 'ooor/finders/version'

Gem::Specification.new do |s|
  s.name         = 'ooor-finders'
  s.version      = Ooor::Finders::VERSION
  s.platform     = Gem::Platform::RUBY
  s.date         = '2012-03-06'
  s.authors      = ["Nicolas Bessi - Camptocamp"]
  s.summary      = %q{OOOR - OpenObject On Ruby dynamic finder extention}
  s.description  = %q{Add Active Record like dynamic finder pattern}
  s.files        = `git ls-files`.split("\n")
  s.require_path = 'lib'
  s.homepage      = "http://github.com/camptocamp/ooor_finders"

  s.add_dependency('ooor', [">= 1.6.5"])

  s.add_development_dependency "rake"
end
