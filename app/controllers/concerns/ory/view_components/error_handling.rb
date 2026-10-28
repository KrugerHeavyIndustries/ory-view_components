# frozen_string_literal: true

module Ory
  module ViewComponents
    module ErrorHandling
      extend ActiveSupport::Concern

      included do
        rescue_from OryClient::ApiError, with: :handle_ory_api_error
      end

      private

      def handle_ory_api_error(error)
        case error.code
        when 404
          handle_flow_not_found
        when 410
          handle_flow_expired
        when 403
          handle_forbidden(error)
        when 422
          handle_browser_location_change(error)
        when 400
          handle_bad_request(error)
        else
          handle_generic_ory_error(error)
        end
      end

      # Kratos refuses to create login/registration flows when the user is
      # already signed in; that isn't an error from the user's point of view.
      def handle_bad_request(error)
        if ory_error_body(error).dig("error", "id") == "session_already_available"
          redirect_to Ory::ViewComponents.configuration.default_return_to, allow_other_host: true
        else
          handle_generic_ory_error(error)
        end
      end

      def handle_flow_not_found
        redirect_to_new_flow
      end

      def handle_flow_expired
        redirect_to_new_flow
      end

      # Kratos uses 403 for several unrelated errors. Only session_aal2_required
      # warrants a step-up login; anything else (e.g. security_csrf_violation)
      # means the current flow is unusable, so start a fresh one.
      def handle_forbidden(error)
        body = ory_error_body(error)
        if body.dig("error", "id") == "session_aal2_required"
          handle_aal_upgrade_required(body)
        else
          redirect_to_new_flow
        end
      end

      def handle_aal_upgrade_required(body = {})
        redirect_url = body["redirect_browser_to"] ||
          ory_view_components.login_path(aal: "aal2", return_to: request.original_url)
        redirect_to redirect_url, allow_other_host: true
      end

      def handle_browser_location_change(error)
        redirect_url = ory_error_body(error)["redirect_browser_to"]
        if redirect_url
          redirect_to redirect_url, allow_other_host: true
        else
          redirect_to_new_flow
        end
      end

      def handle_generic_ory_error(error)
        error_body = ory_error_body(error)
        error_id = error_body.dig("error", "id") || error_body["id"]
        redirect_to ory_view_components.error_path(id: error_id)
      end

      def ory_error_body(error)
        JSON.parse(error.response_body.to_s)
      rescue JSON::ParserError
        {}
      end

      def redirect_to_new_flow
        flow_path = case controller_name
        when "login" then ory_view_components.login_path
        when "registration" then ory_view_components.registration_path
        when "recovery" then ory_view_components.recovery_path
        when "verification" then ory_view_components.verification_path
        when "settings" then ory_view_components.settings_path
        else ory_view_components.login_path
        end

        redirect_to flow_path, allow_other_host: true
      end

      def ory_view_components
        Ory::ViewComponents::Engine.routes.url_helpers
      end
    end
  end
end
