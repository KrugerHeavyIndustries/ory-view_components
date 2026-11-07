# frozen_string_literal: true

module Ory
  module ViewComponents
    class ErrorsController < BaseController
      def show
        if params[:id].present?
          # FlowError#error is untyped in the Ory client, so it arrives as a
          # plain Hash (id, code, status, reason, message) rather than a model.
          @error = ory_frontend.get_flow_error(params[:id]).error&.to_h&.with_indifferent_access
        end
      rescue OryClient::ApiError
        @error = nil
      end
    end
  end
end
