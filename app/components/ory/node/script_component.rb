# frozen_string_literal: true

module Ory
  module Node
    class ScriptComponent < Ory::Component
      def initialize(node:)
        @node = node
        @attributes = node.attributes
      end

      def src
        @attributes.src
      end

      def script_id
        @attributes.id
      end

      def async?
        @attributes.respond_to?(:async) && @attributes.async
      end

      def crossorigin
        @attributes.respond_to?(:crossorigin) ? @attributes.crossorigin : nil
      end

      def integrity
        val = @attributes.respond_to?(:integrity) ? @attributes.integrity : nil
        val.presence
      end

      def nonce
        val = @attributes.respond_to?(:nonce) ? @attributes.nonce : nil
        val.presence
      end

      def referrerpolicy
        @attributes.respond_to?(:referrerpolicy) ? @attributes.referrerpolicy : nil
      end

      def script_type
        @attributes.respond_to?(:type) ? @attributes.type : "text/javascript"
      end
    end
  end
end
