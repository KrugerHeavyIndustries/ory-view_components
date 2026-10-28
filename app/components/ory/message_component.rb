# frozen_string_literal: true

module Ory
  class MessageComponent < Ory::Component
    MESSAGE_TYPES = %w[error info success].freeze

    def initialize(message:)
      @message = message
    end

    def message_text
      @message.text
    end

    def message_type
      @message.type || "info"
    end

    def message_id
      @message.id
    end

    def message_classes
      class_names(
        "Ory-Message",
        "Ory-Message--#{message_type}"
      )
    end
  end
end
