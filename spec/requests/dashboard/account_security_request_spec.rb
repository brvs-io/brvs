# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Dashboard::AccountSecurityController', type: :request do
  let(:current_password) { Faker::Internet.password }
  let(:user) { FactoryBot.create(:user, password: current_password, password_confirmation: current_password) }

  before { sign_in(user) }

  describe 'PATCH /dashboard/user/security' do
    subject(:update_account_security_request) do
      patch '/dashboard/user/security', params: params
    end

    let(:password) { current_password }
    let(:new_password) { Faker::Internet.password }
    let(:params) do
      {
        user: {
          current_password: password,
          password: new_password,
          password_confirmation: new_password
        }
      }
    end

    context 'with valid attributes' do
      it 'redirects to the account security page' do
        update_account_security_request
        expect(response).to redirect_to(dashboard_account_security_path)
      end

      it 'updates the password' do
        update_account_security_request
        expect(user.reload).to be_valid_password(new_password)
      end
    end

    context 'with incorrect password' do
      let(:password) { 'incorrect-password' }

      before { update_account_security_request }

      it 'returns HTTP unprocessable entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not update the password' do
        expect(user.reload).not_to be_valid_password(new_password)
      end
    end
  end
end
