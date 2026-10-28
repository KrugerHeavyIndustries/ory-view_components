# frozen_string_literal: true

module Ory
  class NodeComponent < Ory::Component
    def initialize(node:)
      @node = node
      @attributes = node.attributes
    end

    def call
      case @node.type
      when "img"
        render Ory::Node::ImageComponent.new(node: @node)
      when "text"
        render Ory::Node::TextComponent.new(node: @node)
      when "a"
        render Ory::Node::AnchorComponent.new(node: @node)
      when "script"
        render Ory::Node::ScriptComponent.new(node: @node)
      when "input"
        render_input_node
      end
    end

    private

    def render_input_node
      case @attributes.type
      when "submit", "button"
        render_button_node
      when "checkbox"
        render Ory::Node::CheckboxComponent.new(node: @node)
      when "hidden"
        render Ory::Node::HiddenComponent.new(node: @node)
      else
        if has_select_options?
          render Ory::Node::SelectComponent.new(node: @node)
        else
          render Ory::Node::InputComponent.new(node: @node)
        end
      end
    end

    def render_button_node
      if social_provider_node?
        render Ory::Node::SocialButtonComponent.new(node: @node)
      else
        render Ory::Node::ButtonComponent.new(node: @node)
      end
    end

    def social_provider_node?
      %w[oidc saml].include?(@node.group) &&
        @attributes.respond_to?(:name) &&
        %w[provider link].include?(@attributes.name)
    end

    def has_select_options?
      @attributes.respond_to?(:options) && @attributes.options.is_a?(Array) && @attributes.options.any?
    end
  end
end
