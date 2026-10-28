# frozen_string_literal: true

module Ory
  module ViewComponents
    class RecoveryController < BaseController
      def show
        if params[:flow].blank?
          flow = create_ory_browser_flow(
            :create_browser_recovery_flow,
            return_to: params[:return_to]
          )
          redirect_to recovery_path(flow: flow.id), allow_other_host: true
        else
          flow = ory_frontend.get_recovery_flow(params[:flow], cookie: ory_cookie)
          @flow_container = Ory::ViewComponents::FlowContainer.new(flow: flow, flow_type: :recovery)
        end
      end
    end
  end
end
