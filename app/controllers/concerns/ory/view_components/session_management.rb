# frozen_string_literal: true

module Ory
  module ViewComponents
    module SessionManagement
      extend ActiveSupport::Concern

      included do
        helper_method :current_ory_session if respond_to?(:helper_method)
      end

      private

      def current_ory_session
        return @current_ory_session if defined?(@current_ory_session)

        @current_ory_session = begin
          ory_frontend.to_session(cookie: ory_cookie)
        rescue OryClient::ApiError
          nil
        end
      end

      def require_ory_auth!
        return if current_ory_session

        redirect_to ory_view_components.login_path(return_to: request.original_url), allow_other_host: true
      end

      def require_no_ory_auth!
        return unless current_ory_session

        redirect_to Ory::ViewComponents.configuration.default_return_to
      end
    end
  end
end
