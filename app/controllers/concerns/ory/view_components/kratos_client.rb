# frozen_string_literal: true

module Ory
  module ViewComponents
    module KratosClient
      extend ActiveSupport::Concern

      private

      def ory_frontend
        @ory_frontend ||= OryClient::FrontendApi.new
      end

      def ory_cookie
        request.headers["Cookie"]
      end

      # Creates a browser flow server-side and relays Kratos' Set-Cookie headers
      # (notably the anti-CSRF cookie) to the browser. Without this, fetching
      # the flow afterwards fails with security_csrf_violation.
      def create_ory_browser_flow(method, **opts)
        flow, _status, headers = ory_frontend.public_send(:"#{method}_with_http_info", cookie: ory_cookie, **opts)
        forward_ory_cookies(headers)
        flow
      end

      def forward_ory_cookies(headers)
        Array(headers&.[]("Set-Cookie")).each do |cookie|
          response.add_header("set-cookie", cookie)
        end
      end
    end
  end
end
