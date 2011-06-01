Gem::Specification.new do |s|
  s.name = %q{chaingang}
  s.version = File.read "VERSION"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Matt Parker"]
  s.date = %q{2011-02-23}
  s.description = %q{A chainable API (like Arel) for ActiveResource.}
  s.email = %q{moonmaster9000@gmail.com}
  s.extra_rdoc_files = [
    "readme.md"
  ]
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
 
  s.homepage = %q{http://github.com/moonmaster9000/chaingang}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.5.0}
  s.summary = %q{A chainable API (like Arel) for ActiveResource.}
  
  s.add_dependency(%q<activeresource>, ["~> 3.0"])
  s.add_development_dependency(%q<rspec>, ["~> 2.4.0"])
  s.add_development_dependency("dupe", ["~> 0.6.0"])
end
