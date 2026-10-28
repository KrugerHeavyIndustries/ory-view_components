# frozen_string_literal: true

module Ory
  module Node
    class TextComponent < Ory::Component
      def initialize(node:)
        @node = node
        @attributes = node.attributes
      end

      def text_content
        @attributes.text&.text
      end

      def text_id
        @attributes.id
      end

      def label_text
        @node.meta&.label&.text
      end
    end
  end
end
