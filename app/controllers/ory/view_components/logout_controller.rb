# frozen_string_literal: true

module Ory
  module ViewComponents
    class LogoutController < BaseController
      def show
        logout_flow = ory_frontend.create_browser_logout_flow(
          cookie: ory_cookie,
          return_to: params[:return_to] || Ory::ViewComponents.configuration.default_return_to
        )
        redirect_to logout_flow.logout_url, allow_other_host: true
      rescue OryClient::ApiError
        redirect_to Ory::ViewComponents.configuration.default_return_to
      end
    end
  end
end
