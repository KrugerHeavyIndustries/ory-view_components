# frozen_string_literal: true

module Ory
  module ViewComponents
    class RegistrationController < BaseController
      def show
        if params[:flow].blank?
          flow = create_ory_browser_flow(
            :create_browser_registration_flow,
            return_to: params[:return_to] || Ory::ViewComponents.configuration.default_return_to
          )
          redirect_to registration_path(flow: flow.id), allow_other_host: true
        else
          flow = ory_frontend.get_registration_flow(params[:flow], cookie: ory_cookie)
          @flow_container = Ory::ViewComponents::FlowContainer.new(flow: flow, flow_type: :registration)
        end
      end
    end
  end
end
