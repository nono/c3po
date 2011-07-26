Gem::Specification.new do |s|
  s.name             = "c3po"
  s.version          = "0.1.0"
  s.date             = Time.now.utc.strftime("%Y-%m-%d")
  s.homepage         = "http://github.com/chatgris/c3po"
  s.authors          = "chatgris"
  s.email            = "jboyer@af83.com"
  s.description      = "Ruby translation client"
  s.summary          = "Ruby translation client"
  s.extra_rdoc_files = %w(README.md)
  s.files            = Dir["LICENSE", "README.md", "Gemfile", "lib/**/*.rb", "init.rb"]
  s.require_paths    = ["lib"]
  s.rubygems_version = %q{1.8.3}
  s.add_development_dependency "rspec", "~>2.6"
  s.add_dependency "typhoeus", "~>0.2.4"
  s.add_dependency "yajl-ruby", "~>0.8.2"
end
