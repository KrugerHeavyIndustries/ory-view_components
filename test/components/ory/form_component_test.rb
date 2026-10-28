# frozen_string_literal: true

require "test_helper"

class Ory::FormComponentTest < Minitest::Test
  include Ory::ComponentTestHelpers
  include FlowFixtures

  def test_renders_form_with_correct_action_and_method
    flow = build_login_flow
    render_inline(Ory::FormComponent.new(flow: flow))

    assert_selector "form[action='#{flow.ui.action}'][method='POST'][novalidate]"
  end

  def test_renders_hidden_csrf_token
    flow = build_login_flow
    render_inline(Ory::FormComponent.new(flow: flow))

    assert_selector "input[type='hidden'][name='csrf_token']", visible: :hidden
  end

  def test_renders_input_fields
    flow = build_login_flow
    render_inline(Ory::FormComponent.new(flow: flow))

    assert_selector "input[name='identifier']"
    assert_selector "input[name='password']"
  end

  def test_renders_submit_button
    flow = build_login_flow
    render_inline(Ory::FormComponent.new(flow: flow))

    assert_selector ".Ory-Form__Actions button[type='submit']"
  end

  def test_excludes_social_nodes
    nodes = [
      build_hidden_node(name: "csrf_token", value: "token"),
      build_input_node(name: "identifier", type: "text", label: "Email"),
      build_social_node(provider: "google")
    ]
    flow = build_login_flow(nodes: nodes)
    render_inline(Ory::FormComponent.new(flow: flow))

    assert_selector "input[name='identifier']"
    assert_no_selector "button[name='provider']"
  end
end
