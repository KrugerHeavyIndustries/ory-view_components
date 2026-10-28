# frozen_string_literal: true

module Ory
  class CardComponent < Ory::Component
    renders_one :header, Ory::Card::HeaderComponent
    renders_one :body, Ory::Card::ContentComponent
    renders_one :footer, Ory::Card::FooterComponent

    def initialize(**system_arguments)
      @system_arguments = system_arguments
    end
  end
end
