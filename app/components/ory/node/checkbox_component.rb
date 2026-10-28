# frozen_string_literal: true

module Ory
  module Node
    class CheckboxComponent < Ory::Component
      def initialize(node:)
        @node = node
        @attributes = node.attributes
      end

      def input_name
        @attributes.name
      end

      def label_text
        @node.meta&.label&.text
      end

      def checked?
        @attributes.value == true || @attributes.value == "true"
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
    end
  end
end
