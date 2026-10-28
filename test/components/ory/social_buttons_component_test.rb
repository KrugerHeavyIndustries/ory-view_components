# frozen_string_literal: true

require "test_helper"

class Ory::SocialButtonsComponentTest < Minitest::Test
  include Ory::ComponentTestHelpers
  include FlowFixtures

  def test_renders_social_buttons_in_separate_form
    nodes = [
      build_hidden_node(name: "csrf_token", value: "token"),
      build_social_node(provider: "google"),
      build_social_node(provider: "github")
    ]
    flow = build_login_flow(nodes: nodes)
    render_inline(Ory::SocialButtonsComponent.new(flow: flow))

    assert_selector "form.Ory-SocialButtons__Form"
    assert_selector ".Ory-SocialButton", count: 2
  end

  def test_includes_csrf_token
    nodes = [
      build_hidden_node(name: "csrf_token", value: "token"),
      build_social_node(provider: "google")
    ]
    flow = build_login_flow(nodes: nodes)
    render_inline(Ory::SocialButtonsComponent.new(flow: flow))

    assert_selector "input[type='hidden'][name='csrf_token']", visible: :hidden
  end

  def test_does_not_render_when_no_social_nodes
    flow = build_login_flow
    component = Ory::SocialButtonsComponent.new(flow: flow)
    refute component.render?
  end

  def test_grid_columns_for_three_providers
    nodes = [
      build_hidden_node(name: "csrf_token", value: "token"),
      build_social_node(provider: "google"),
      build_social_node(provider: "github"),
      build_social_node(provider: "apple")
    ]
    flow = build_login_flow(nodes: nodes)
    component = Ory::SocialButtonsComponent.new(flow: flow)

    assert_equal 3, component.grid_columns
  end
end
