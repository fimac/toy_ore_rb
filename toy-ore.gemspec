Gem::Specification.new do |s|
  s.name = "toy-ore"
  s.version = "0.5.0"
  s.summary = "toy-ore"
  s.description = "A toy library to get an understanding of how order revealing encryption works. This is an unsafe implementation, only to be used for educational purposes. DO NOT USE IN PRODUCTION."
  s.authors = ["Fiona McCawley"]
  s.email = "fimccawley@gmail.com"
  s.files = ["lib/toy_ore.rb", "lib/toy_ore/scheme.rb"]
  s.homepage =
    "https://rubygems.org/gems/toy-ore"
  s.license = "MIT"
  s.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  s.metadata["allowed_push_host"] = "https://rubygems.org"
  s.metadata["source_code_uri"] = "https://github.com/fimac/toy_ore_rb"
  s.metadata["documentation_uri"] = "https://rubydoc.info/gems/toy-ore"
  s.rdoc_options = ["--main", "README.rdoc",
                    "--title", "Ruby Toy ORE Library: Educational tool to learn about Order Revealing Encryption"]
  s.extra_rdoc_files = `git ls-files -z *.rdoc lib/*.rb lib/*/*.rb ext/*.c ext/*.h`.split("\x0")

  s.add_development_dependency "rspec", "~> 3.0"
  s.add_development_dependency "pry"
  s.add_development_dependency "debug", ">= 1.0.0"
  s.add_development_dependency "pry-byebug"
end
