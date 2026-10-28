# frozen_string_literal: true

module Ory
  module Node
    class ButtonComponent < Ory::Component
      def initialize(node:)
        @node = node
        @attributes = node.attributes
      end

      def button_name
        @attributes.name
      end

      def button_value
        @attributes.value
      end

      def label_text
        @node.meta&.label&.text || button_value.to_s.capitalize
      end

      def disabled?
        @attributes.respond_to?(:disabled) && @attributes.disabled
      end

      def button_type
        @attributes.type == "button" ? "button" : "submit"
      end

      def button_classes
        class_names(
          "Ory-Node__Button",
          {"Ory-Node__Button--primary": primary?}
        )
      end

      private

      def primary?
        @attributes.name == "method" || @node.group != "default"
      end
    end
  end
end
