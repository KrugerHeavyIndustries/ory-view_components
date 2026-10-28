# frozen_string_literal: true

module Ory
  class MessagesComponent < Ory::Component
    FILTERED_MESSAGE_IDS = [
      1_040_009, 1_060_003, 1_080_003, 1_010_004, 1_010_014,
      1_010_025, 1_040_005, 1_010_016, 1_010_003, 1_060_004,
      1_060_005, 1_060_006
    ].freeze

    def initialize(messages:)
      @messages = Array(messages)
    end

    def visible_messages
      @messages.reject { |m| FILTERED_MESSAGE_IDS.include?(m.id) }
    end

    def render?
      visible_messages.any?
    end
  end
end
