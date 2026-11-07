# frozen_string_literal: true

require "rails/generators/base"

module Ory
  module ViewComponents
    module Generators
      class ViewsGenerator < ::Rails::Generators::Base
        namespace "ory_view_components:views"
        source_root File.expand_path("../../../app", __dir__)

        desc "Copies the default Ory ViewComponents views and layout to your application for customization."

        class_option :components, type: :boolean, default: false,
          desc: "Also copy the components (Ruby classes and templates), which then replace the engine's versions"

        def copy_views
          directory "views/ory/view_components", "app/views/ory/view_components"
        end

        def copy_layout
          directory "views/layouts/ory/view_components", "app/views/layouts/ory/view_components"
        end

        def copy_components
          return unless options[:components]

          directory "components/ory", "app/components/ory"
        end
      end
    end
  end
end
