$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ar_cacheable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ar_cacheable"
  s.version     = ArCacheable::VERSION
  s.authors     = ["t1732"]
  s.email       = ["oo1732oo@gmail.com"]
  s.homepage    = ""
  s.license     = "MIT"
  s.summary     = "Summary of ArCacheable."
  s.description = "Description of ArCacheable."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  # s.add_dependency "rails", "~> 4.0.1.rc3"
  s.add_dependency "activerecord"

  s.add_development_dependency "sqlite3"
end
