# frozen_string_literal: true

module Ory
  module ViewComponents
    class ErrorsController < BaseController
      def show
        if params[:id].present?
          @error = ory_frontend.get_flow_error(params[:id])
        end
      rescue OryClient::ApiError
        @error = nil
      end
    end
  end
end
