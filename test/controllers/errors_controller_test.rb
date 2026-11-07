# frozen_string_literal: true

require "test_helper"
require "minitest/mock"

class Ory::ViewComponents::ErrorsControllerTest < ActionDispatch::IntegrationTest
  FakeFrontend = Struct.new(:flow_error) do
    def get_flow_error(_id, **)
      flow_error || raise(OryClient::ApiError.new(code: 404))
    end
  end

  def test_shows_message_and_reason_from_kratos_error
    # Built the way the Ory client deserializes it: the error field stays a Hash with symbol keys.
    flow_error = OryClient::FlowError.build_from_hash(
      id: "error-1",
      error: {
        code: 400,
        status: "Bad Request",
        message: "The request was malformed or contained invalid parameters",
        reason: "Requested return_to URL is not allowed."
      }
    )

    get_error(flow_error)

    assert_response :success
    assert_select ".Ory-Error__Message", text: "The request was malformed or contained invalid parameters"
    assert_select ".Ory-Error__Reason", text: "Requested return_to URL is not allowed."
  end

  def test_shows_unknown_error_when_kratos_has_no_such_error
    get_error(nil)

    assert_response :success
    assert_select ".Ory-Error__Message", text: "An unknown error occurred."
    assert_select ".Ory-Error__Reason", count: 0
  end

  private

  def get_error(flow_error)
    OryClient::FrontendApi.stub(:new, FakeFrontend.new(flow_error)) { get "/auth/error", params: {id: "error-1"} }
  end
end
