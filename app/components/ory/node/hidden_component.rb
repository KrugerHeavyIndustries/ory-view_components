# frozen_string_literal: true

module Ory
  module Node
    class HiddenComponent < Ory::Component
      def initialize(node:)
        @node = node
        @attributes = node.attributes
      end

      def input_name
        @attributes.name
      end

      def input_value
        @attributes.value
      end
    end
  end
end
