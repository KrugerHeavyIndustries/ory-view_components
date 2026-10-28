# frozen_string_literal: true

module Ory
  class FormComponent < Ory::Component
    include Ory::NodeHelper

    def initialize(flow:, nodes: nil, group: nil, exclude_groups: nil)
      @flow = flow
      @group = group
      @exclude_groups = exclude_groups
      @all_nodes = nodes || flow.ui.nodes
    end

    def form_action
      @flow.ui.action
    end

    def form_method
      @flow.ui.method
    end

    def hidden_form_nodes
      filtered = scoped_nodes
      hidden_nodes(filtered)
    end

    def visible_form_nodes
      filtered = scoped_nodes
      visible_nodes(filtered).reject { |n| %w[oidc saml].include?(n.group) }
    end

    def content_nodes
      visible_form_nodes.reject { |n| n.type == "input" && %w[submit button].include?(n.attributes.type) }
    end

    def submit_form_nodes
      visible_form_nodes.select { |n| n.type == "input" && %w[submit button].include?(n.attributes.type) }
    end

    private

    def scoped_nodes
      nodes = @all_nodes
      if @group
        nodes = nodes_for_group(nodes, @group)
      end
      if @exclude_groups
        nodes = filter_nodes(nodes, exclude_groups: Array(@exclude_groups))
      end
      nodes
    end
  end
end
