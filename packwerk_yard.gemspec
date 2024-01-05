# frozen_string_literal: true

require_relative "lib/packwerk_yard/version"

Gem::Specification.new do |spec|
  spec.name = "packwerk_yard"
  spec.version = PackwerkYard::VERSION
  spec.authors = ["Teppei Shintani"]
  spec.email = ["teppest1215@gmail.com"]

  spec.summary = "Parsing YARD plugin for packwerk"
  spec.description = "Parsing YARD plugin for packwerk"
  spec.homepage = "https://github.com/euglena1215/packwerk-yard"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/euglena1215/packwerk-yard"
  spec.metadata["changelog_uri"] = "https://github.com/euglena1215/packwerk-yard/blob/main/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "yard"
  spec.add_dependency "parser"
end
