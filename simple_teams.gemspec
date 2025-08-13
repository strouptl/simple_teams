require_relative "lib/simple_teams/version"

Gem::Specification.new do |spec|
  spec.name        = "simple_teams"
  spec.version     = SimpleTeams::VERSION
  spec.authors     = ["Thomas Laney Stroup"]
  spec.email       = ["laney@stroupsolutions.com"]
  spec.homepage    = "https://github.com/strouptl/simple_teams"
  spec.summary     = "A simple gem for adding teams to a Ruby on Rails application"
  spec.description = "SimpleTeams is an all-in-one solution for implementing teams quickly in a Ruby on Rails (RoR) application. It follows best practices, using the Rails Engine design pattern for easy configurability, CanCan for authorization, and polymorphic association (like ActiveStorage) to avoid dictating model names."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/strouptl/simple_teams"
  spec.metadata["changelog_uri"] = "https://github.com/strouptl/simple_teams/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", "~> 8.0.0"
  spec.add_dependency "devise", "~> 4.9.4"
  spec.add_dependency "cancancan", "~> 3.6.0"
  spec.add_dependency "noticed", "~> 2.8.0"
  spec.add_dependency "simple_form", "~> 5.3.0"
end
