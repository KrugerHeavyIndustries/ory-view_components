# frozen_string_literal: true

require "test_helper"

class Ory::Node::ButtonComponentTest < Minitest::Test
  include Ory::ComponentTestHelpers
  include FlowFixtures

  def test_renders_submit_button
    node = build_submit_node(name: "method", value: "password", label: "Sign In")
    render_inline(Ory::Node::ButtonComponent.new(node: node))

    assert_selector "button[type='submit'][name='method'][value='password']", text: "Sign In"
  end

  def test_renders_primary_style_for_method_button
    node = build_submit_node(name: "method", value: "password", label: "Sign In")
    render_inline(Ory::Node::ButtonComponent.new(node: node))

    assert_selector ".Ory-Node__Button--primary"
  end

  def test_renders_disabled_button
    node = build_input_node(name: "method", type: "submit", value: "password", label: "Sign In", disabled: true)
    render_inline(Ory::Node::ButtonComponent.new(node: node))

    assert_selector "button[disabled]"
  end
end
