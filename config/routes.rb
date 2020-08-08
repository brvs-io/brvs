# frozen_string_literal: true

Rails.application.routes.draw do # rubocop:disable Metrics/BlockLength
  scope format: false do
    devise_for :users, only: :sessions, path: '.dashboard', path_names: { sign_in: 'login', sign_out: 'logout' }
    devise_scope :user do
      unless ENV['REGISTRATION_DISABLED']
        get '/register', to: 'devise/registrations#new', as: :new_user_registration, format: false
        post '/register', to: 'devise/registrations#create', as: :user_registration, format: false
      end

      resource :confirmation, only: %i[new create show], path_names: { new: 'resend' },
                              path: '/dashboard/user/verify-email', controller: 'devise/confirmations',
                              as: :user_confirmation

      resource :password, only: %I[new create edit update], path_names: { new: 'recover', edit: 'reset' },
                          path: '/dashboard/user/password', controller: 'devise/passwords', as: :user_password

      resource :unlock, only: %i[new create show], path_names: { new: 'resend' },
                        path: '/dashboard/user/unlock', controller: 'devise/unlocks', as: :user_unlock
    end

    namespace :dashboard, path: '/dashboard' do
      resource :account, path: 'user', controller: :accounts, only: %i[show update destroy]

      resources :account_applications, path: 'user/applications'
      resource :account_notifications, path: 'user/notifications', only: %i[show update]
      resource :account_security, path: 'user/security', controller: :account_security, only: %i[show update]

      resources :links

      root to: 'home#index'
    end
  end

  root to: 'home#index'

  resources :links, path: '', only: %i[create show update destroy]
end
