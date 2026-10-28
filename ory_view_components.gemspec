# frozen_string_literal: true

require_relative "lib/ory/view_components/version"

Gem::Specification.new do |spec|
  spec.name = "ory_view_components"
  spec.version = Ory::ViewComponents::VERSION
  spec.authors = ["Chris Kruger"]
  spec.summary = "Rails ViewComponents for Ory Kratos identity flows"
  spec.description = "A mountable Rails engine providing ViewComponents that render Ory Kratos self-service UI flows (login, registration, recovery, verification, settings)."
  spec.homepage = "https://github.com/KrugerHeavyIndustries/ory-view_components"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"

  spec.files = Dir["lib/**/*", "app/**/*", "config/**/*", "LICENSE.txt", "README.md"]
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", ">= 7.1.0"
  spec.add_dependency "view_component", ">= 3.0.0", "< 5.0"
  spec.add_dependency "ory-client", "~> 1.22"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
end
