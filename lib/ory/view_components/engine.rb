# frozen_string_literal: true

module Ory
  module ViewComponents
    class Engine < ::Rails::Engine
      isolate_namespace Ory::ViewComponents

      initializer "ory_view_components.assets" do |app|
        if app.config.respond_to?(:assets)
          app.config.assets.precompile += %w[
            ory_view_components.js
            ory_view_components.css
          ]
        end
      end

      initializer "ory_view_components.importmap", before: "importmap" do |app|
        if app.config.respond_to?(:importmap) && app.config.importmap.respond_to?(:cache_sweepers)
          app.config.importmap.cache_sweepers << Engine.root.join("app/assets/javascripts")
        end
      end

      initializer "ory_view_components.helpers" do
        ActiveSupport.on_load(:action_controller_base) do
          helper Ory::ViewHelper
        end
      end

      initializer "ory_view_components.kratos_client" do
        config.after_initialize do
          cfg = Ory::ViewComponents.configuration
          kratos_uri = URI.parse(cfg.kratos_url)

          OryClient.configure do |c|
            c.scheme = kratos_uri.scheme
            c.host = "#{kratos_uri.host}:#{kratos_uri.port}"
            c.base_path = kratos_uri.path.presence || ""
            c.ignore_operation_servers = true
          end
        end
      end
    end
  end
end
