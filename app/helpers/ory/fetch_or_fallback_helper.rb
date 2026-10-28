# frozen_string_literal: true

module Ory
  module FetchOrFallbackHelper
    InvalidValueError = Class.new(StandardError)

    def fetch_or_fallback(allowed_values, value, fallback)
      if allowed_values.include?(value)
        value
      elsif Rails.env.production?
        fallback
      else
        raise InvalidValueError, "Invalid value #{value.inspect}. Allowed: #{allowed_values.inspect}"
      end
    end
  end
end
