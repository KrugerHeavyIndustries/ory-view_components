# frozen_string_literal: true

require "test_helper"

class Ory::Settings::SectionComponentTest < Minitest::Test
  include Ory::ComponentTestHelpers
  include FlowFixtures

  def test_renders_profile_section
    flow = build_settings_flow
    render_inline(Ory::Settings::SectionComponent.new(
      flow: flow,
      group: "profile",
      title: "Profile",
      description: "Update your info."
    ))

    assert_selector "form.Ory-Settings__Section"
    assert_selector ".Ory-Settings__SectionTitle", text: "Profile"
    assert_selector ".Ory-Settings__SectionDescription", text: "Update your info."
    assert_selector "input[name='traits.email']"
  end

  def test_renders_submit_in_footer
    flow = build_settings_flow
    render_inline(Ory::Settings::SectionComponent.new(
      flow: flow,
      group: "profile",
      title: "Profile"
    ))

    assert_selector ".Ory-Settings__SectionFooter button[type='submit']"
  end

  def test_does_not_render_when_group_has_no_nodes
    flow = build_settings_flow
    component = Ory::Settings::SectionComponent.new(
      flow: flow,
      group: "totp",
      title: "TOTP"
    )
    refute component.render?
  end
end
