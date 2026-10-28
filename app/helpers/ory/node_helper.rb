# frozen_string_literal: true

module Ory
  module NodeHelper
    module_function

    def filter_nodes(nodes, groups: nil, exclude_groups: nil, types: nil, exclude_types: nil)
      result = nodes.dup
      result = result.select { |n| Array(groups).include?(n.group) } if groups
      result = result.reject { |n| Array(exclude_groups).include?(n.group) } if exclude_groups
      result = result.select { |n| Array(types).include?(n.type) } if types
      result = result.reject { |n| Array(exclude_types).include?(n.type) } if exclude_types
      result
    end

    def nodes_for_group(nodes, group)
      default_nodes = nodes.select { |n| n.group == "default" }
      group_nodes = nodes.select { |n| n.group == group.to_s }
      default_nodes + group_nodes
    end

    def hidden_nodes(nodes)
      nodes.select { |n| n.type == "input" && n.attributes.respond_to?(:type) && n.attributes.type == "hidden" }
    end

    def visible_nodes(nodes)
      nodes - hidden_nodes(nodes)
    end

    def submit_nodes(nodes, group: nil)
      result = nodes.select { |n| n.type == "input" && n.attributes.respond_to?(:type) && %w[submit button].include?(n.attributes.type) }
      result = result.select { |n| n.group == group.to_s } if group
      result
    end

    def input_nodes(nodes, group: nil)
      result = nodes.select { |n| n.type == "input" && n.attributes.respond_to?(:type) && !%w[submit button hidden].include?(n.attributes.type) }
      result = result.select { |n| n.group == group.to_s } if group
      result
    end

    def social_nodes(nodes)
      nodes.select { |n| %w[oidc saml].include?(n.group) }
    end

    def script_nodes(nodes)
      nodes.select { |n| n.type == "script" }
    end

    def find_node_by_name(nodes, name)
      nodes.find { |n| n.attributes.respond_to?(:name) && n.attributes.name == name.to_s }
    end

    def find_node_by_id(nodes, id)
      nodes.find { |n| n.attributes.respond_to?(:id) && n.attributes.id == id.to_s }
    end

    def node_groups(nodes, omit: [])
      nodes
        .reject { |n| omit.include?(n.type) }
        .map(&:group)
        .uniq
        .reject { |g| g == "default" }
    end

    def has_social_nodes?(nodes)
      social_nodes(nodes).any?
    end
  end
end
