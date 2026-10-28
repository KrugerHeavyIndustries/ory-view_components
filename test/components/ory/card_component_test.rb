# frozen_string_literal: true

require "test_helper"

class Ory::CardComponentTest < Minitest::Test
  include Ory::ComponentTestHelpers
  include FlowFixtures

  def test_renders_card_with_all_slots
    render_inline(Ory::CardComponent.new) do |card|
      card.with_header(title: "Sign In")
      card.with_body { "Form content" }
      card.with_footer { "Footer content" }
    end

    assert_selector ".Ory-Card"
    assert_selector ".Ory-Card__Header .Ory-Card__Title", text: "Sign In"
    assert_selector ".Ory-Card__Body", text: "Form content"
    assert_selector ".Ory-Card__Footer", text: "Footer content"
  end

  def test_renders_card_with_header_description
    render_inline(Ory::CardComponent.new) do |card|
      card.with_header(title: "Recovery", description: "Enter your email")
    end

    assert_selector ".Ory-Card__Description", text: "Enter your email"
  end

  def test_renders_card_without_optional_slots
    render_inline(Ory::CardComponent.new) do |card|
      card.with_body { "Just content" }
    end

    assert_selector ".Ory-Card"
    assert_selector ".Ory-Card__Body", text: "Just content"
    assert_no_selector ".Ory-Card__Header"
    assert_no_selector ".Ory-Card__Footer"
  end
end
