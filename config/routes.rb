# frozen_string_literal: true

Ory::ViewComponents::Engine.routes.draw do
  get "login", to: "login#show", as: :login
  get "registration", to: "registration#show", as: :registration
  get "recovery", to: "recovery#show", as: :recovery
  get "verification", to: "verification#show", as: :verification
  get "settings", to: "settings#show", as: :settings
  get "consent", to: "consent#show", as: :consent
  get "logout", to: "logout#show", as: :logout
  get "error", to: "errors#show", as: :error
end
