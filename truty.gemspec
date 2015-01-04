
Gem::Specification.new do |s|
  s.name        = 'truty'
  s.version     = '0.1.1'
  s.platform    = Gem::Platform::RUBY
  s.summary     = "True typography converter"
  s.description = "A string converter which aims to correct the typography."
  s.authors     = ["Matěj Kašpar Jirásek"]
  s.email       = 'matej.jirasek@me.com'
  s.files       = Dir["{lib}/**/*.rb", "bin/*", "LICENSE", "*.md"]
  s.homepage    = 'https://github.com/mkj-is/Truty'
  s.bindir      = 'bin'
  s.license     = 'MIT'

  s.required_ruby_version = '>= 2.0.0'

  s.add_dependency 'text-hyphen', '~> 1.4'
  s.add_development_dependency 'test-unit', '~> 3.0'
  s.add_development_dependency 'simplecov', '~> 0.9'
  s.add_development_dependency 'yard', '~> 0.8'

end
