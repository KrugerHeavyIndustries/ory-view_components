# frozen_string_literal: true

module Ory
  module ViewHelper
    ORY_HELPERS = {
      ory_card: "Ory::CardComponent",
      ory_form: "Ory::FormComponent",
      ory_node: "Ory::NodeComponent",
      ory_messages: "Ory::MessagesComponent",
      ory_message: "Ory::MessageComponent",
      ory_social_buttons: "Ory::SocialButtonsComponent",
      ory_divider: "Ory::DividerComponent"
    }.freeze

    ORY_HELPERS.each do |name, component_class|
      define_method(name) do |*args, **kwargs, &block|
        render component_class.constantize.new(*args, **kwargs), &block
      end
    end
  end
end
