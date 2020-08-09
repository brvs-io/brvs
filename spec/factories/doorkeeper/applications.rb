# frozen_string_literal: true

FactoryBot.define do
  factory :oauth_application, class: 'Doorkeeper::Application' do
    owner factory: :user
    name { Faker::App.name }
    redirect_uri { 'urn:ietf:wg:oauth:2.0:oob' }

    trait :public do
      confidential { false }
    end
  end
end
