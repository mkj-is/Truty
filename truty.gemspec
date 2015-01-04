
Gem::Specification.new do |s|
  s.name        = 'truty'
  s.version     = '0.1.0'
  s.platform    = Gem::Platform::RUBY
  s.summary     = "True typography converter"
  s.description = "A string converter which aims to correct the typography."
  s.authors     = ["Matěj Kašpar Jirásek"]
  s.email       = 'matej.jirasek@me.com'
  s.files        = Dir["{lib}/**/*.rb", "bin/*", "LICENSE", "*.md"]
  s.homepage    = 'https://github.com/mkj-is/Truty'
  s.executables = ["truty"]
  s.license       = 'MIT'

  s.add_dependency 'text-hyphen', '~> 1.4'
  s.add_development_dependency 'simplecov', '~> 0.9'
  s.add_development_dependency 'yard', '~> 0.8'

end
