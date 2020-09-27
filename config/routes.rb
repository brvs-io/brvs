# frozen_string_literal: true

Rails.application.routes.draw do # rubocop:disable Metrics/BlockLength
  scope format: false do # rubocop:disable Metrics/BlockLength
    constraints host: Rails.configuration.x.default_domain do # rubocop:disable Metrics/BlockLength
      use_doorkeeper do
        skip_controllers :applications, :authorized_applications
      end

      devise_for :users, only: :sessions, path: 'dashboard', path_names: { sign_in: 'login', sign_out: 'logout' }
      devise_for :users, only: :omniauth_callbacks, controllers: { omniauth_callbacks: 'dashboard/omniauth_callbacks' }
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

      namespace :api do
        resource :user, only: %i[show]
        resources :links, only: %i[index create show update destroy]
        resources :domains, only: %i[index create show update destroy]

        root to: 'root#index'
      end

      namespace :dashboard, path: '/dashboard' do
        resource :account_profile, path: 'user', only: %i[show update destroy]

        resources :account_authorized_applications, path: 'user/applications/authorized', only: %i[index show destroy] do # rubocop:disable Layout/LineLength
          delete :revoke_all, path: 'revoke-all', on: :collection
        end
        resources :account_developer_applications, path: 'users/applications/developer' do
          delete :revoke, on: :member
          delete :secret, on: :member
        end
        resource :account_notifications, path: 'user/notifications', only: %i[show update]
        resource :account_security, path: 'user/security', controller: :account_security, only: %i[show update]

        resources :domains
        resources :links

        root to: 'home#index'
      end
    end
  end

  root to: 'home#index'

  resources :links, path: '', only: %i[show]
end
