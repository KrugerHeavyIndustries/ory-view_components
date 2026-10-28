# frozen_string_literal: true

Rails.application.routes.draw do
  mount Ory::ViewComponents::Engine, at: "/auth", as: :ory

  root to: "welcome#index"
end
