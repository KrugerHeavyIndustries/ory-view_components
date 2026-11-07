# frozen_string_literal: true

require "test_helper"
require "rails/generators/test_case"
require "generators/ory_view_components/views_generator"

class Ory::ViewComponents::Generators::ViewsGeneratorTest < Rails::Generators::TestCase
  ENGINE_APP = Ory::ViewComponents::Engine.root.join("app")

  tests Ory::ViewComponents::Generators::ViewsGenerator
  destination Rails.root.join("tmp/generators")
  setup :prepare_destination

  def test_copies_every_view_and_the_layout_unchanged
    run_generator

    assert_copied "views/ory/view_components"
    assert_copied "views/layouts/ory/view_components"
  end

  def test_does_not_copy_components_by_default
    run_generator

    assert_no_directory "app/components"
  end

  def test_copies_every_component_with_the_components_option
    run_generator %w[--components]

    assert_copied "components/ory"
  end

  private

  def assert_copied(relative_dir)
    sources = Dir.glob(ENGINE_APP.join(relative_dir, "**/*")).select { |path| File.file?(path) }
    assert_not_empty sources

    sources.each do |source|
      relative_path = Pathname(source).relative_path_from(ENGINE_APP)
      assert_file File.join("app", relative_path) do |copied|
        assert_equal File.read(source), copied
      end
    end
  end
end
