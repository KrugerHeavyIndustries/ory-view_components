# frozen_string_literal: true

module Ory
  module Settings
    class RecoveryCodesComponent < Ory::Component
      include Ory::NodeHelper

      def initialize(flow:)
        @flow = flow
        @nodes = nodes_for_group(flow.ui.nodes, "lookup_secret")
      end

      def form_action
        @flow.ui.action
      end

      def form_method
        @flow.ui.method
      end

      def code_nodes
        @nodes.select { |n| n.type == "text" }
      end

      def action_nodes
        @nodes.select { |n|
          n.type == "input" &&
            n.attributes.respond_to?(:type) &&
            %w[submit button].include?(n.attributes.type) &&
            n.group == "lookup_secret"
        }
      end

      def hidden_lookup_nodes
        hidden_nodes(@nodes)
      end

      def render?
        @nodes.any? { |n| n.group == "lookup_secret" }
      end
    end
  end
end
