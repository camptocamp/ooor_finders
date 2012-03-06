Gem::Specification.new do |s|
  s.name = %q{ooor_finders}
  s.version = "0.1"
  s.date = %q{2013-03-06}
  s.authors = ["Nicolas Bessi - Camptocamp"]
  s.summary = %q{OOOR - OpenObject On Ruby dynamic finder extention}
  s.description = %q{Add Active Record like dynamic finder pattern}
  s.files = [ "README.md", "lib/ooor_finders.rb", "lib/open_object_resource.rb", "lib/dynamic_finder_match.rb"]
  s.add_dependency(%q<ooor>, [">= 1.6.5"])
end