$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "bliss_attachments/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "bliss_attachments"
  s.version     = BlissAttachments::VERSION
  s.authors     = ["Fadendaten GmbH"]
  s.email       = ["support@fadendaten.ch"]
  s.homepage    = "www.fadendaten.ch"
  s.summary     = "Bliss wrapper around paperclip gem"
  s.description = "Attachment Model wrapped around paperclip"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.mdown"]

  s.add_dependency "rails", "~> 3.2.14"
  s.add_dependency "paperclip", "~> 3.5.1"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
end
