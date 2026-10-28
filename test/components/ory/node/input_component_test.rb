# frozen_string_literal: true

require "test_helper"

class Ory::Node::InputComponentTest < Minitest::Test
  include Ory::ComponentTestHelpers
  include FlowFixtures

  def test_renders_text_input
    node = build_input_node(name: "identifier", type: "text", label: "Email", required: true)
    render_inline(Ory::Node::InputComponent.new(node: node))

    assert_selector "input[name='identifier'][type='text'][required]"
    assert_selector "label[for='identifier']", text: "Email"
  end

  def test_renders_password_input
    node = build_input_node(name: "password", type: "password", label: "Password")
    render_inline(Ory::Node::InputComponent.new(node: node))

    assert_selector "input[name='password'][type='password']"
  end

  def test_renders_disabled_input
    node = build_input_node(name: "email", type: "email", disabled: true)
    render_inline(Ory::Node::InputComponent.new(node: node))

    assert_selector "input[disabled]"
  end

  def test_renders_input_with_value
    node = build_input_node(name: "identifier", type: "text", value: "user@example.com")
    render_inline(Ory::Node::InputComponent.new(node: node))

    assert_selector "input[value='user@example.com']"
  end

  def test_renders_error_messages
    node = build_input_node(
      name: "password",
      type: "password",
      messages: [{id: 4000006, text: "Password too short", type: "error"}]
    )
    render_inline(Ory::Node::InputComponent.new(node: node))

    assert_selector ".Ory-Node__Input--error"
    assert_selector ".Ory-Message--error", text: "Password too short"
  end

  def test_renders_without_label
    node = build_input_node(name: "code", type: "text")
    render_inline(Ory::Node::InputComponent.new(node: node))

    assert_no_selector "label"
    assert_selector "input[name='code']"
  end
end
