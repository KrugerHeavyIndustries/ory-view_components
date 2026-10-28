# frozen_string_literal: true

module Ory
  module Settings
    class OidcComponent < Ory::Component
      include Ory::NodeHelper

      def initialize(flow:)
        @flow = flow
        @nodes = nodes_for_group(flow.ui.nodes, "oidc")
      end

      def form_action
        @flow.ui.action
      end

      def form_method
        @flow.ui.method
      end

      def provider_nodes
        @nodes.select { |n| n.group == "oidc" && n.type == "input" && n.attributes.respond_to?(:type) && %w[submit button].include?(n.attributes.type) }
      end

      def hidden_oidc_nodes
        hidden_nodes(@nodes)
      end

      def render?
        provider_nodes.any?
      end
    end
  end
end
