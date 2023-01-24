Gem::Specification.new do |s|
  s.name        = "toy-ore"
  s.version     = "0.1.0"
  s.summary     = "toy-ore"
  s.description = "A toy library to test out ore encryption. This is an unsafe implementation, only to be used for educational purposes."
  s.authors     = ["Fiona McCawley"]
  s.email       = "fimccawley@gmail.com"
  s.files       = ["lib/toy_ore.rb", "lib/toy_ore/scheme.rb"]
  s.homepage    =
    "https://rubygems.org/gems/toy-ore"
  s.license       = "MIT"

  s.add_development_dependency "rspec", "~> 3.0"
end
