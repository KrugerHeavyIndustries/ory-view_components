# frozen_string_literal: true

require "view_component"
require "ory-client"

require "ory/view_components/version"
require "ory/view_components/configuration"
require "ory/view_components/engine"

module Ory
  module ViewComponents
    class << self
      def configuration
        @configuration ||= Configuration.new
      end

      def configure
        yield(configuration)
      end
    end
  end
end
