# frozen_string_literal: true

module Ory
  class Component < ViewComponent::Base
    include Ory::ClassNameHelper
    include Ory::FetchOrFallbackHelper
  end
end
