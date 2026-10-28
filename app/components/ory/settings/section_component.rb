# frozen_string_literal: true

module Ory
  module Settings
    class SectionComponent < Ory::Component
      include Ory::NodeHelper

      def initialize(flow:, group:, title:, description: nil)
        @flow = flow
        @group = group.to_s
        @title = title
        @description = description
        @nodes = nodes_for_group(flow.ui.nodes, @group)
      end

      def form_action
        @flow.ui.action
      end

      def form_method
        @flow.ui.method
      end

      def hidden_section_nodes
        hidden_nodes(@nodes)
      end

      def content_section_nodes
        visible_nodes(@nodes).reject { |n| n.type == "input" && %w[submit button].include?(n.attributes.type) }
      end

      def submit_section_nodes
        submit_nodes(@nodes, group: @group)
      end

      def render?
        @nodes.any? { |n| n.group == @group }
      end
    end
  end
end
