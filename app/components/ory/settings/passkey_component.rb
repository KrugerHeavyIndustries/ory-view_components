# frozen_string_literal: true

module Ory
  module Settings
    class PasskeyComponent < Ory::Component
      include Ory::NodeHelper

      def initialize(flow:)
        @flow = flow
        @nodes = nodes_for_group(flow.ui.nodes, "passkey")
      end

      def form_action
        @flow.ui.action
      end

      def form_method
        @flow.ui.method
      end

      def trigger_node
        find_node_by_name(@nodes, "passkey_register_trigger")
      end

      def remove_nodes
        @nodes.select { |n|
          n.type == "input" &&
            n.attributes.respond_to?(:name) &&
            n.attributes.name == "passkey_remove"
        }
      end

      def hidden_passkey_nodes
        hidden_nodes(@nodes)
      end

      def render?
        @nodes.any? { |n| n.group == "passkey" }
      end
    end
  end
end
