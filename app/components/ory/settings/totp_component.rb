# frozen_string_literal: true

module Ory
  module Settings
    class TotpComponent < Ory::Component
      include Ory::NodeHelper

      def initialize(flow:)
        @flow = flow
        @nodes = nodes_for_group(flow.ui.nodes, "totp")
      end

      def form_action
        @flow.ui.action
      end

      def form_method
        @flow.ui.method
      end

      def qr_node
        @nodes.find { |n| n.type == "img" && n.attributes.respond_to?(:id) && n.attributes.id == "totp_qr" }
      end

      def secret_node
        @nodes.find { |n| n.type == "text" && n.attributes.respond_to?(:id) && n.attributes.id == "totp_secret_key" }
      end

      def code_node
        find_node_by_name(@nodes, "totp_code")
      end

      def unlink_node
        find_node_by_name(@nodes, "totp_unlink")
      end

      def method_node
        @nodes.find { |n| n.type == "input" && n.attributes.respond_to?(:name) && n.attributes.name == "method" && n.attributes.type == "submit" && n.group == "totp" }
      end

      def hidden_totp_nodes
        hidden_nodes(@nodes)
      end

      def linked?
        unlink_node.present?
      end

      def render?
        @nodes.any? { |n| n.group == "totp" }
      end
    end
  end
end
