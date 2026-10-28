# frozen_string_literal: true

module Ory
  class DividerComponent < Ory::Component
    def initialize(text: nil)
      @text = text
    end

    def divider_text
      @text || I18n.t("ory.divider.or")
    end
  end
end
