# frozen_string_literal: true

module Ory
  module Card
    class FooterComponent < Ory::Component
      def initialize(**system_arguments)
        @system_arguments = system_arguments
      end
    end
  end
end
