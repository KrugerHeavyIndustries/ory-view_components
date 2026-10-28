# frozen_string_literal: true

module FlowFixtures
  UiText = Struct.new(:id, :text, :type, :context, keyword_init: true)
  UiNodeMeta = Struct.new(:label, keyword_init: true)
  UiContainer = Struct.new(:action, :method, :nodes, :messages, keyword_init: true)

  UiNodeInputAttributes = Struct.new(
    :name, :type, :value, :required, :disabled, :pattern,
    :node_type, :autocomplete, :maxlength, :options,
    :onclick_trigger, :onload_trigger,
    keyword_init: true
  ) do
    def id
      name
    end
  end

  UiNodeTextAttributes = Struct.new(:id, :text, :node_type, keyword_init: true)
  UiNodeImageAttributes = Struct.new(:id, :src, :width, :height, :node_type, keyword_init: true)
  UiNodeAnchorAttributes = Struct.new(:id, :href, :title, :node_type, keyword_init: true)
  UiNodeScriptAttributes = Struct.new(
    :id, :src, :async, :crossorigin, :integrity,
    :nonce, :referrerpolicy, :type, :node_type,
    keyword_init: true
  )

  UiNode = Struct.new(:type, :group, :attributes, :messages, :meta, keyword_init: true)

  FlowObject = Struct.new(:id, :type, :issued_at, :expires_at, :request_url, :ui, :state, :active, :identity, keyword_init: true)

  def build_ui_text(id: 1_000_000, text: "Test message", type: "info", context: nil)
    UiText.new(id: id, text: text, type: type, context: context)
  end

  def build_ui_node_meta(label: nil)
    UiNodeMeta.new(label: label)
  end

  def build_input_attributes(name:, type: "text", value: nil, required: false, disabled: false, pattern: nil, node_type: "input", autocomplete: nil, options: nil)
    UiNodeInputAttributes.new(
      name: name, type: type, value: value, required: required,
      disabled: disabled, pattern: pattern, node_type: node_type,
      autocomplete: autocomplete, options: options
    )
  end

  def build_text_attributes(id:, text:, node_type: "text")
    UiNodeTextAttributes.new(id: id, text: build_ui_text(text: text), node_type: node_type)
  end

  def build_image_attributes(id:, src:, width: 200, height: 200, node_type: "img")
    UiNodeImageAttributes.new(id: id, src: src, width: width, height: height, node_type: node_type)
  end

  def build_anchor_attributes(id:, href:, title:, node_type: "a")
    UiNodeAnchorAttributes.new(id: id, href: href, title: build_ui_text(text: title), node_type: node_type)
  end

  def build_script_attributes(id:, src:, async: true, crossorigin: "anonymous", integrity: "", nonce: "", referrerpolicy: "no-referrer", type: "text/javascript", node_type: "script")
    UiNodeScriptAttributes.new(
      id: id, src: src, async: async, crossorigin: crossorigin,
      integrity: integrity, nonce: nonce, referrerpolicy: referrerpolicy,
      type: type, node_type: node_type
    )
  end

  def build_ui_node(type:, group: "default", attributes:, messages: [], meta_label: nil)
    msgs = messages.map { |m| m.is_a?(UiText) ? m : build_ui_text(**m) }
    label = meta_label ? build_ui_text(text: meta_label) : nil
    UiNode.new(type: type, group: group, attributes: attributes, messages: msgs, meta: build_ui_node_meta(label: label))
  end

  def build_input_node(name:, type: "text", group: "default", value: nil, required: false, disabled: false, label: nil, messages: [], **attrs)
    build_ui_node(
      type: "input",
      group: group,
      attributes: build_input_attributes(name: name, type: type, value: value, required: required, disabled: disabled, **attrs),
      messages: messages,
      meta_label: label
    )
  end

  def build_hidden_node(name:, value:, group: "default")
    build_input_node(name: name, type: "hidden", value: value, group: group)
  end

  def build_submit_node(name:, value:, group: "default", label: nil)
    build_input_node(name: name, type: "submit", value: value, group: group, label: label || value.to_s.capitalize)
  end

  def build_social_node(provider:, group: "oidc")
    build_input_node(
      name: "provider",
      type: "submit",
      value: provider,
      group: group,
      label: "Sign in with #{provider.capitalize}"
    )
  end

  def build_text_node(id:, text:, group: "default")
    build_ui_node(
      type: "text",
      group: group,
      attributes: build_text_attributes(id: id, text: text)
    )
  end

  def build_image_node(id:, src:, group: "default", width: 200, height: 200)
    build_ui_node(
      type: "img",
      group: group,
      attributes: build_image_attributes(id: id, src: src, width: width, height: height)
    )
  end

  def build_anchor_node(id:, href:, title:, group: "default")
    build_ui_node(
      type: "a",
      group: group,
      attributes: build_anchor_attributes(id: id, href: href, title: title)
    )
  end

  def build_script_node(id:, src:, group: "webauthn")
    build_ui_node(
      type: "script",
      group: group,
      attributes: build_script_attributes(id: id, src: src)
    )
  end

  def build_ui_container(action: "https://kratos.example.com/self-service/login?flow=test-flow-id", method: "POST", nodes: [], messages: [])
    msgs = messages.map { |m| m.is_a?(UiText) ? m : build_ui_text(**m) }
    UiContainer.new(action: action, method: method, nodes: nodes, messages: msgs)
  end

  def build_login_flow(nodes: nil, messages: [], id: "test-login-flow-id")
    default_nodes = nodes || [
      build_hidden_node(name: "csrf_token", value: "test-csrf-token"),
      build_input_node(name: "identifier", type: "text", label: "Email", required: true),
      build_input_node(name: "password", type: "password", group: "password", label: "Password", required: true),
      build_submit_node(name: "method", value: "password", group: "password", label: "Sign In")
    ]

    FlowObject.new(
      id: id,
      type: "browser",
      issued_at: Time.now,
      expires_at: Time.now + 3600,
      request_url: "https://kratos.example.com/self-service/login/browser",
      ui: build_ui_container(
        action: "https://kratos.example.com/self-service/login?flow=#{id}",
        nodes: default_nodes,
        messages: messages
      )
    )
  end

  def build_registration_flow(nodes: nil, messages: [], id: "test-registration-flow-id")
    default_nodes = nodes || [
      build_hidden_node(name: "csrf_token", value: "test-csrf-token"),
      build_input_node(name: "traits.email", type: "email", label: "Email", required: true),
      build_input_node(name: "password", type: "password", group: "password", label: "Password", required: true),
      build_submit_node(name: "method", value: "password", group: "password", label: "Sign Up")
    ]

    FlowObject.new(
      id: id,
      type: "browser",
      issued_at: Time.now,
      expires_at: Time.now + 3600,
      request_url: "https://kratos.example.com/self-service/registration/browser",
      ui: build_ui_container(
        action: "https://kratos.example.com/self-service/registration?flow=#{id}",
        nodes: default_nodes,
        messages: messages
      )
    )
  end

  def build_settings_flow(nodes: nil, messages: [], id: "test-settings-flow-id")
    default_nodes = nodes || [
      build_hidden_node(name: "csrf_token", value: "test-csrf-token"),
      build_input_node(name: "traits.email", type: "email", group: "profile", label: "Email"),
      build_submit_node(name: "method", value: "profile", group: "profile", label: "Save"),
      build_input_node(name: "password", type: "password", group: "password", label: "New Password"),
      build_submit_node(name: "method", value: "password", group: "password", label: "Change Password")
    ]

    FlowObject.new(
      id: id,
      type: "browser",
      issued_at: Time.now,
      expires_at: Time.now + 3600,
      request_url: "https://kratos.example.com/self-service/settings/browser",
      ui: build_ui_container(
        action: "https://kratos.example.com/self-service/settings?flow=#{id}",
        nodes: default_nodes,
        messages: messages
      )
    )
  end
end
