# frozen_string_literal: true

require "test_helper"

class Ory::Node::SocialButtonComponentTest < Minitest::Test
  include Ory::ComponentTestHelpers
  include FlowFixtures

  def test_renders_social_button
    node = build_social_node(provider: "google")
    render_inline(Ory::Node::SocialButtonComponent.new(node: node))

    assert_selector "button.Ory-SocialButton[name='provider'][value='google']"
    assert_selector ".Ory-SocialButton--google"
  end

  def test_renders_label_text
    node = build_social_node(provider: "github")
    render_inline(Ory::Node::SocialButtonComponent.new(node: node))

    assert_selector ".Ory-SocialButton__Label", text: /github/i
  end

  def test_handles_compound_provider_names
    node = build_social_node(provider: "google-workspace")
    render_inline(Ory::Node::SocialButtonComponent.new(node: node))

    assert_selector ".Ory-SocialButton--google"
  end
end
