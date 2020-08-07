# frozen_string_literal: true

Rails.application.routes.draw do
  scope format: false do
    devise_for :users, only: :sessions, path: '', path_names: { sign_in: 'login', sign_out: 'logout' }
    devise_scope :user do
      unless ENV['REGISTRATION_DISABLED']
        get '/register', to: 'devise/registrations#new', as: :new_user_registration, format: false
        post '/register', to: 'devise/registrations#create', as: :user_registration, format: false
      end

      resource :confirmation, only: %i[new create show], path_names: { new: 'resend' },
                              path: '/user/verify-email', controller: 'devise/confirmations', as: :user_confirmation

      resource :password, only: %I[new create edit update], path_names: { new: 'recover', edit: 'reset' },
                          path: '/user/password', controller: 'devise/passwords', as: :user_password

      resource :unlock, only: %i[new create show], path_names: { new: 'resend' },
                        path: '/user/unlock', controller: 'devise/unlocks', as: :user_unlock
    end

    resource :user, controller: :accounts, only: %i[show update destroy]
  end

  root to: 'home#index'
end
