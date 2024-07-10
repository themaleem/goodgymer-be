# frozen_string_literal: true

Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations: 'overrides/registrations'

  }

  resources :goodgymers, only: %i[index create]
  resources :registrations, only: %i[create destroy]
  resources :sessions, only: %i[index create destroy]

  resources :users, only: %i[] do
    collection do
      get :logged_in_user
    end
  end
end
