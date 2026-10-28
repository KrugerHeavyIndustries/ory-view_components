# frozen_string_literal: true

module Ory
  module ViewComponents
    class VerificationController < BaseController
      def show
        if params[:flow].blank?
          flow = create_ory_browser_flow(
            :create_browser_verification_flow,
            return_to: params[:return_to]
          )
          redirect_to verification_path(flow: flow.id), allow_other_host: true
        else
          flow = ory_frontend.get_verification_flow(params[:flow], cookie: ory_cookie)
          @flow_container = Ory::ViewComponents::FlowContainer.new(flow: flow, flow_type: :verification)
        end
      end
    end
  end
end
