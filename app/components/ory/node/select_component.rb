# frozen_string_literal: true

module Ory
  module Node
    class SelectComponent < Ory::Component
      def initialize(node:)
        @node = node
        @attributes = node.attributes
      end

      def label_text
        @node.meta&.label&.text
      end

      def input_name
        @attributes.name
      end

      def current_value
        @attributes.value
      end

      def options
        @attributes.options || []
      end

      def required?
        @attributes.respond_to?(:required) && @attributes.required
      end

      def disabled?
        @attributes.respond_to?(:disabled) && @attributes.disabled
      end

      def messages
        @node.messages || []
      end

      def has_errors?
        messages.any? { |m| m.type == "error" }
      end

      def select_classes
        class_names(
          "Ory-Node__Select",
          {"Ory-Node__Select--error": has_errors?}
        )
      end
    end
  end
end
