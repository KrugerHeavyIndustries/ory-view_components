# frozen_string_literal: true

module Ory
  module ViewComponents
    class SettingsController < BaseController
      before_action :require_ory_auth!

      def show
        if params[:flow].blank?
          flow = create_ory_browser_flow(
            :create_browser_settings_flow,
            return_to: params[:return_to]
          )
          redirect_to settings_path(flow: flow.id), allow_other_host: true
        else
          flow = ory_frontend.get_settings_flow(params[:flow], cookie: ory_cookie)
          @flow_container = Ory::ViewComponents::FlowContainer.new(flow: flow, flow_type: :settings)
        end
      end
    end
  end
end
