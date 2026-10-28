# frozen_string_literal: true

require "test_helper"

class Ory::MessagesComponentTest < Minitest::Test
  include Ory::ComponentTestHelpers
  include FlowFixtures

  def test_renders_error_message
    messages = [build_ui_text(id: 4000001, text: "Invalid credentials", type: "error")]
    render_inline(Ory::MessagesComponent.new(messages: messages))

    assert_selector ".Ory-Message--error", text: "Invalid credentials"
  end

  def test_renders_success_message
    messages = [build_ui_text(id: 1000000, text: "Settings updated", type: "success")]
    render_inline(Ory::MessagesComponent.new(messages: messages))

    assert_selector ".Ory-Message--success", text: "Settings updated"
  end

  def test_renders_info_message
    messages = [build_ui_text(id: 1000001, text: "Check your email", type: "info")]
    render_inline(Ory::MessagesComponent.new(messages: messages))

    assert_selector ".Ory-Message--info", text: "Check your email"
  end

  def test_filters_excluded_message_ids
    messages = [
      build_ui_text(id: 1_060_003, text: "Filtered message", type: "info"),
      build_ui_text(id: 9999999, text: "Visible message", type: "info")
    ]
    render_inline(Ory::MessagesComponent.new(messages: messages))

    assert_no_text "Filtered message"
    assert_text "Visible message"
  end

  def test_does_not_render_when_empty
    component = Ory::MessagesComponent.new(messages: [])
    refute component.render?
  end

  def test_handles_nil_messages
    component = Ory::MessagesComponent.new(messages: nil)
    refute component.render?
  end
end
