# frozen_string_literal: true

module Ory
  module Settings
    class WebauthnComponent < Ory::Component
      include Ory::NodeHelper

      def initialize(flow:)
        @flow = flow
        @nodes = nodes_for_group(flow.ui.nodes, "webauthn")
      end

      def form_action
        @flow.ui.action
      end

      def form_method
        @flow.ui.method
      end

      def name_node
        find_node_by_name(@nodes, "webauthn_register_displayname")
      end

      def trigger_node
        find_node_by_name(@nodes, "webauthn_register_trigger")
      end

      def register_node
        find_node_by_name(@nodes, "webauthn_register")
      end

      def remove_nodes
        @nodes.select { |n|
          n.type == "input" &&
            n.attributes.respond_to?(:name) &&
            n.attributes.name == "webauthn_remove"
        }
      end

      def hidden_webauthn_nodes
        hidden_nodes(@nodes)
      end

      def render?
        @nodes.any? { |n| n.group == "webauthn" }
      end
    end
  end
end
