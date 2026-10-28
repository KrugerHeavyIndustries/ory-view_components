# frozen_string_literal: true

require_relative "boot"

require "rails"
require "action_controller/railtie"
require "action_view/railtie"
require "active_model/railtie"
require "sprockets/railtie" if defined?(Sprockets)

Bundler.require(*Rails.groups)
require "ory_view_components"

module Demo
  class Application < Rails::Application
    config.load_defaults Rails::VERSION::STRING.to_f
    config.eager_load = false
    config.secret_key_base = "test-secret-key-base-for-demo-app"
  end
end
