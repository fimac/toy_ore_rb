Gem::Specification.new do |s|
  s.name        = "toy-ore"
  s.version     = "0.1.0"
  s.summary     = "toy-ore"
  s.description = "A toy library to get an understanding of how ore encryption works. This is an unsafe implementation, only to be used for educational purposes. DO NOT USE IN PRODUCTION."
  s.authors     = ["Fiona McCawley"]
  s.email       = "fimccawley@gmail.com"
  s.files       = ["lib/toy_ore.rb", "lib/toy_ore/scheme.rb"]
  s.homepage    =
    "https://rubygems.org/gems/toy-ore"
  s.license       = "MIT"

  s.add_development_dependency "rspec", "~> 3.0"
  s.add_development_dependency 'pry'
  s.add_development_dependency "debug", ">= 1.0.0"
  s.add_development_dependency "pry-byebug"
end
