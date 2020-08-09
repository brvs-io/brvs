# frozen_string_literal: true

FactoryBot.define do
  factory :oauth_access_token, class: 'Doorkeeper::AccessToken' do
    resource_owner factory: :user
    application factory: :oauth_application
    scopes { %i[users:profile:read] }
  end
end
