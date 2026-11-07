# frozen_string_literal: true

require "test_helper"
require "minitest/mock"

class WelcomeTest < ActionDispatch::IntegrationTest
  FakeFrontend = Struct.new(:session) do
    def to_session(**)
      session || raise(OryClient::ApiError.new(code: 401))
    end
  end

  def test_signed_out_shows_entry_links
    get_root(session: nil)

    assert_response :success
    assert_select ".Ory-Card__Title", text: "Ory ViewComponents Demo"
    assert_select "a[href=?]", "/auth/login", text: "Sign in"
    assert_select "a[href=?]", "/auth/registration"
    assert_select "a[href=?]", "/auth/recovery"
    assert_select "a[href=?]", "/auth/verification"
    assert_select "a[href=?]", "/auth/logout", count: 0
  end

  def test_signed_in_shows_session_details_and_account_links
    get_root(session: build_session)

    assert_response :success
    assert_select ".Ory-Card__Title", text: "You're signed in"
    assert_select ".Ory-Card__Description", text: "ada@example.com"

    details = css_select(".Demo-Details").text
    assert_includes details, "identity-123"
    assert_includes details, "session-456"
    assert_includes details, "aal1"
    assert_includes details, "name.first"
    assert_includes details, "Ada"

    body = css_select(".Ory-Card__Body").text
    assert_includes body, "password"
    assert_includes body, "203.0.113.7"
    assert_includes body, "verified"

    assert_select "a[href=?]", "/auth/settings"
    assert_select "a[href=?]", "/auth/login?refresh=true", text: "Re-authenticate"
    assert_select "a[href=?]", "/auth/logout", text: "Log out"
    assert_select "a[href=?]", "/auth/registration", count: 0
  end

  private

  def get_root(session:)
    OryClient::FrontendApi.stub(:new, FakeFrontend.new(session)) { get "/" }
  end

  def build_session
    OryClient::Session.build_from_hash(
      id: "session-456",
      active: true,
      authenticator_assurance_level: "aal1",
      authenticated_at: 1.hour.ago.iso8601,
      issued_at: 1.hour.ago.iso8601,
      expires_at: 23.hours.from_now.iso8601,
      authentication_methods: [{method: "password", aal: "aal1", completed_at: 1.hour.ago.iso8601}],
      devices: [{id: "device-1", ip_address: "203.0.113.7", user_agent: "Mozilla/5.0", location: "Sydney, AU"}],
      identity: {
        id: "identity-123",
        schema_id: "default",
        schema_url: "http://localhost:4433/schemas/default",
        state: "active",
        traits: {email: "ada@example.com", name: {first: "Ada", last: "Lovelace"}},
        verifiable_addresses: [
          {id: "address-1", value: "ada@example.com", via: "email", status: "completed", verified: true}
        ]
      }
    )
  end
end
