# frozen_string_literal: true

module Ory
  module ViewComponents
    class LoginController < BaseController
      def show
        if params[:flow].blank?
          flow = create_ory_browser_flow(
            :create_browser_login_flow,
            return_to: params[:return_to] || Ory::ViewComponents.configuration.default_return_to,
            refresh: params[:refresh],
            aal: params[:aal]
          )
          redirect_to login_path(flow: flow.id), allow_other_host: true
        else
          flow = ory_frontend.get_login_flow(params[:flow], cookie: ory_cookie)
          @flow_container = Ory::ViewComponents::FlowContainer.new(flow: flow, flow_type: :login)
        end
      end
    end
  end
end
