# frozen_string_literal: true

module Ory
  module Node
    class ImageComponent < Ory::Component
      def initialize(node:)
        @node = node
        @attributes = node.attributes
      end

      def image_src
        @attributes.src
      end

      def image_id
        @attributes.id
      end

      def image_width
        @attributes.width
      end

      def image_height
        @attributes.height
      end

      def label_text
        @node.meta&.label&.text
      end
    end
  end
end
