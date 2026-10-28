# frozen_string_literal: true

module Ory
  module Card
    class ContentComponent < Ory::Component
      def initialize(**system_arguments)
        @system_arguments = system_arguments
      end
    end
  end
end
