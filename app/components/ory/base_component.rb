# frozen_string_literal: true

module Ory
  class BaseComponent < Ory::Component
    def initialize(tag:, classes: nil, **system_arguments)
      @tag = tag
      @classes = classes
      @system_arguments = system_arguments
    end

    def call
      content_tag(@tag, content, class: @classes, **@system_arguments)
    end
  end
end
