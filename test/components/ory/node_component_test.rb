# frozen_string_literal: true

require "test_helper"

class Ory::NodeComponentTest < Minitest::Test
  include Ory::ComponentTestHelpers
  include FlowFixtures

  def test_renders_input_node
    node = build_input_node(name: "identifier", type: "text", label: "Email")
    render_inline(Ory::NodeComponent.new(node: node))
    assert_selector "input[name='identifier'][type='text']"
    assert_selector "label", text: "Email"
  end

  def test_renders_hidden_node
    node = build_hidden_node(name: "csrf_token", value: "abc123")
    render_inline(Ory::NodeComponent.new(node: node))
    assert_selector "input[type='hidden'][name='csrf_token'][value='abc123']", visible: :hidden
  end

  def test_renders_submit_button_node
    node = build_submit_node(name: "method", value: "password", label: "Sign In")
    render_inline(Ory::NodeComponent.new(node: node))
    assert_selector "button[type='submit'][name='method'][value='password']", text: "Sign In"
  end

  def test_renders_social_button_for_oidc_provider
    node = build_social_node(provider: "google")
    render_inline(Ory::NodeComponent.new(node: node))
    assert_selector "button[name='provider'][value='google']"
    assert_selector ".Ory-SocialButton"
  end

  def test_renders_text_node
    node = build_text_node(id: "totp_secret_key", text: "JBSWY3DPEHPK3PXP")
    render_inline(Ory::NodeComponent.new(node: node))
    assert_selector ".Ory-Node--text", text: "JBSWY3DPEHPK3PXP"
  end

  def test_renders_image_node
    node = build_image_node(id: "totp_qr", src: "data:image/png;base64,abc")
    render_inline(Ory::NodeComponent.new(node: node))
    assert_selector "img[src='data:image/png;base64,abc']"
  end

  def test_renders_anchor_node
    node = build_anchor_node(id: "backup", href: "https://example.com", title: "Click here")
    render_inline(Ory::NodeComponent.new(node: node))
    assert_selector "a[href='https://example.com']", text: "Click here"
  end

  def test_renders_script_node
    node = build_script_node(id: "webauthn_script", src: "https://example.com/webauthn.js")
    render_inline(Ory::NodeComponent.new(node: node))
    assert_selector "script[src='https://example.com/webauthn.js']", visible: :hidden
  end

  def test_renders_checkbox_node
    node = build_input_node(name: "remember", type: "checkbox", label: "Remember me")
    render_inline(Ory::NodeComponent.new(node: node))
    assert_selector "input[type='checkbox'][name='remember']"
    assert_selector ".Ory-Node__CheckboxText", text: "Remember me"
  end
end
