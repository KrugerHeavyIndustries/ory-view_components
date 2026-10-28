# frozen_string_literal: true

namespace :ory_view_components do
  desc "Install Ory ViewComponents"
  task :install do
    Rails::Command.invoke :app, ["template", File.expand_path("../install/install.rb", __dir__)]
  end
end
