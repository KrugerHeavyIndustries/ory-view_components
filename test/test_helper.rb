# frozen_string_literal: true

ENV["RAILS_ENV"] = "test"

require File.expand_path("../demo/config/environment.rb", __dir__)
require "minitest/autorun"
require "view_component/test_helpers"
require "test_helpers/component_test_helper"
require "test_helpers/flow_fixtures"
