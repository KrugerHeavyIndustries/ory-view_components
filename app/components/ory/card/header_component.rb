# frozen_string_literal: true

module Ory
  module Card
    class HeaderComponent < Ory::Component
      def initialize(title:, description: nil)
        @title = title
        @description = description
      end
    end
  end
end
