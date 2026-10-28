# frozen_string_literal: true

require "test_helper"

class NodeHelperTest < Minitest::Test
  include FlowFixtures

  def test_filter_nodes_by_group
    nodes = [
      build_input_node(name: "email", group: "default"),
      build_input_node(name: "password", group: "password"),
      build_social_node(provider: "google")
    ]

    result = Ory::NodeHelper.filter_nodes(nodes, groups: ["password"])
    assert_equal 1, result.size
    assert_equal "password", result.first.attributes.name
  end

  def test_filter_nodes_exclude_groups
    nodes = [
      build_input_node(name: "email", group: "default"),
      build_social_node(provider: "google")
    ]

    result = Ory::NodeHelper.filter_nodes(nodes, exclude_groups: ["oidc"])
    assert_equal 1, result.size
    assert_equal "email", result.first.attributes.name
  end

  def test_nodes_for_group_includes_default
    nodes = [
      build_hidden_node(name: "csrf_token", value: "token"),
      build_input_node(name: "password", group: "password"),
      build_input_node(name: "totp_code", group: "totp")
    ]

    result = Ory::NodeHelper.nodes_for_group(nodes, "password")
    assert_equal 2, result.size
    names = result.map { |n| n.attributes.name }
    assert_includes names, "csrf_token"
    assert_includes names, "password"
  end

  def test_hidden_nodes
    nodes = [
      build_hidden_node(name: "csrf_token", value: "token"),
      build_input_node(name: "email", type: "text")
    ]

    result = Ory::NodeHelper.hidden_nodes(nodes)
    assert_equal 1, result.size
    assert_equal "csrf_token", result.first.attributes.name
  end

  def test_social_nodes
    nodes = [
      build_input_node(name: "email", group: "default"),
      build_social_node(provider: "google"),
      build_social_node(provider: "github")
    ]

    result = Ory::NodeHelper.social_nodes(nodes)
    assert_equal 2, result.size
  end

  def test_find_node_by_name
    nodes = [
      build_input_node(name: "email"),
      build_input_node(name: "password")
    ]

    result = Ory::NodeHelper.find_node_by_name(nodes, "password")
    assert_equal "password", result.attributes.name
  end

  def test_submit_nodes
    nodes = [
      build_input_node(name: "email", type: "text"),
      build_submit_node(name: "method", value: "password"),
      build_submit_node(name: "method", value: "oidc", group: "oidc")
    ]

    result = Ory::NodeHelper.submit_nodes(nodes)
    assert_equal 2, result.size

    result_filtered = Ory::NodeHelper.submit_nodes(nodes, group: "oidc")
    assert_equal 1, result_filtered.size
  end

  def test_node_groups
    nodes = [
      build_input_node(name: "csrf", group: "default"),
      build_input_node(name: "password", group: "password"),
      build_social_node(provider: "google"),
      build_input_node(name: "totp_code", group: "totp")
    ]

    result = Ory::NodeHelper.node_groups(nodes)
    assert_includes result, "password"
    assert_includes result, "oidc"
    assert_includes result, "totp"
    refute_includes result, "default"
  end
end
