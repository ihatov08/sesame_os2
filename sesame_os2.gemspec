# frozen_string_literal: true

require_relative "lib/sesame_os2/version"

Gem::Specification.new do |spec|
  spec.name          = "sesame_os2"
  spec.version       = SesameOs2::VERSION
  spec.authors       = ["ihatov08"]
  spec.email         = ["ihatov08@gmail.com"]

  spec.summary       = "Ruby wrapper for CANDIHOUSE sesame os2 Web API"
  spec.homepage      = "https://github.com/ihatov08/sesame_os2"
  spec.license       = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ihatov08/sesame_os2"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'digest-cmac'
  spec.add_dependency 'faraday'

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
