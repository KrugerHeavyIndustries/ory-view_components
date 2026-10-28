# frozen_string_literal: true

module Ory
  module Node
    class AnchorComponent < Ory::Component
      def initialize(node:)
        @node = node
        @attributes = node.attributes
      end

      def href
        @attributes.href
      end

      def anchor_id
        @attributes.id
      end

      def title_text
        @attributes.title&.text
      end
    end
  end
end
