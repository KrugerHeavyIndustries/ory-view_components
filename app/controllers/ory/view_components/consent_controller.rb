# frozen_string_literal: true

module Ory
  module ViewComponents
    class ConsentController < BaseController
      def show
        if params[:consent_challenge].blank?
          redirect_to login_path
        else
          @consent_challenge = params[:consent_challenge]
        end
      end
    end
  end
end
