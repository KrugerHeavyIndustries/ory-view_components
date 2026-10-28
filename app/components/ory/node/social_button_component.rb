# frozen_string_literal: true

module Ory
  module Node
    class SocialButtonComponent < Ory::Component
      def initialize(node:)
        @node = node
        @attributes = node.attributes
      end

      def provider
        @attributes.value
      end

      def provider_name
        provider.to_s.split("-").first&.capitalize || provider.to_s.capitalize
      end

      def button_name
        @attributes.name
      end

      def label_text
        @node.meta&.label&.text || "Sign in with #{provider_name}"
      end

      def disabled?
        @attributes.respond_to?(:disabled) && @attributes.disabled
      end

      def provider_class
        "Ory-SocialButton--#{provider.to_s.split("-").first}"
      end
    end
  end
end
