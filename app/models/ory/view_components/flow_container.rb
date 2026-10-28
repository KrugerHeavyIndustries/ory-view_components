# frozen_string_literal: true

module Ory
  module ViewComponents
    class FlowContainer
      FLOW_TYPES = %i[login registration recovery verification settings consent].freeze

      attr_reader :flow, :flow_type

      def initialize(flow:, flow_type:)
        @flow = flow
        @flow_type = flow_type.to_sym
      end

      def ui
        flow.ui
      end

      def nodes
        ui.nodes
      end

      def messages
        ui.messages || []
      end

      def action
        ui.action
      end

      def expired?
        flow.respond_to?(:expires_at) && flow.expires_at && Time.parse(flow.expires_at.to_s) < Time.now
      rescue ArgumentError
        false
      end
    end
  end
end
