# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Dashboard login', type: :request do
  let(:password) { Faker::Internet.password }
  let(:user) { FactoryBot.create(:user, password: password, password_confirmation: password) }

  it 'redirects to the dashboard homepage on successful login' do
    post new_user_session_path, params: { user: { email: user.email, password: password } }
    expect(response).to redirect_to(dashboard_root_path)
  end
end
