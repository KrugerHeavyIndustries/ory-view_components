# frozen_string_literal: true

say "Installing Ory ViewComponents..."

initializer "ory.rb", <<~RUBY
  Ory::ViewComponents.configure do |config|
    config.kratos_url = ENV.fetch("ORY_KRATOS_URL", "http://localhost:4433")
    config.default_return_to = "/"
  end
RUBY

route 'mount Ory::ViewComponents::Engine, at: "/auth", as: :ory'

say "Ory ViewComponents installed successfully!"
say "Configure your Kratos URL in config/initializers/ory.rb"
