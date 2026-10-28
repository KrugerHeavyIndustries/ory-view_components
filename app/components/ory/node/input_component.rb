# frozen_string_literal: true

module Ory
  module Node
    class InputComponent < Ory::Component
      def initialize(node:)
        @node = node
        @attributes = node.attributes
      end

      def label_text
        @node.meta&.label&.text
      end

      def input_type
        @attributes.type || "text"
      end

      def input_name
        @attributes.name
      end

      def input_value
        @attributes.value
      end

      def required?
        @attributes.respond_to?(:required) && @attributes.required
      end

      def disabled?
        @attributes.respond_to?(:disabled) && @attributes.disabled
      end

      def autocomplete
        @attributes.respond_to?(:autocomplete) ? @attributes.autocomplete : nil
      end

      def pattern
        @attributes.respond_to?(:pattern) ? @attributes.pattern : nil
      end

      def maxlength
        @attributes.respond_to?(:maxlength) ? @attributes.maxlength : nil
      end

      def messages
        @node.messages || []
      end

      def has_errors?
        messages.any? { |m| m.type == "error" }
      end

      def input_classes
        class_names(
          "Ory-Node__Input",
          {"Ory-Node__Input--error": has_errors?}
        )
      end
    end
  end
end
