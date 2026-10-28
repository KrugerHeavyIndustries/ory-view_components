# frozen_string_literal: true

Ory::ViewComponents.configure do |config|
  config.kratos_url = ENV.fetch("ORY_KRATOS_URL", "http://localhost:4433")
  config.default_return_to = "/"
end
