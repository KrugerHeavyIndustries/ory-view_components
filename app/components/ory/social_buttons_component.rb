# frozen_string_literal: true

module Ory
  class SocialButtonsComponent < Ory::Component
    include Ory::NodeHelper

    def initialize(flow:)
      @flow = flow
    end

    def social_button_nodes
      social_nodes(@flow.ui.nodes)
    end

    def render?
      social_button_nodes.any?
    end

    def form_action
      @flow.ui.action
    end

    def form_method
      @flow.ui.method
    end

    def csrf_node
      find_node_by_name(@flow.ui.nodes, "csrf_token")
    end

    def grid_columns
      count = social_button_nodes.size
      if (count % 4).zero? && count > 1
        4
      elsif (count % 3).zero? && count > 1
        3
      else
        1
      end
    end

    def grid_class
      "Ory-SocialButtons--cols-#{grid_columns}"
    end
  end
end
