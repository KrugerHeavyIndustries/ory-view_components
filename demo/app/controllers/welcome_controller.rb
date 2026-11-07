# frozen_string_literal: true

class WelcomeController < ApplicationController
  include Ory::ViewComponents::KratosClient
  include Ory::ViewComponents::SessionManagement

  layout "ory/view_components/application"

  def index
  end
end
