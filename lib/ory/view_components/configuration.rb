# frozen_string_literal: true

module Ory
  module ViewComponents
    class Configuration
      attr_accessor :kratos_url,
        :kratos_public_url,
        :default_return_to,
        :layout,
        :session_cookie_name

      def initialize
        @kratos_url = ENV.fetch("ORY_KRATOS_URL", "http://localhost:4433")
        @kratos_public_url = ENV.fetch("ORY_KRATOS_PUBLIC_URL", @kratos_url)
        @default_return_to = "/"
        @layout = nil
        @session_cookie_name = "ory_kratos_session"
      end
    end
  end
end
