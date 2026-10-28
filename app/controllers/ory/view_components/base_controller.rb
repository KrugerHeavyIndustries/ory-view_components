# frozen_string_literal: true

module Ory
  module ViewComponents
    class BaseController < ActionController::Base
      include Ory::ViewComponents::KratosClient
      include Ory::ViewComponents::SessionManagement
      include Ory::ViewComponents::ErrorHandling

      layout -> { Ory::ViewComponents.configuration.layout || "ory/view_components/application" }
    end
  end
end
