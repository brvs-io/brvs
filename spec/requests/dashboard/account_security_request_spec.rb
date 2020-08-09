# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Account security settings', type: :request do
  let(:current_password) { Faker::Internet.password }
  let(:user) { FactoryBot.create(:user, password: current_password, password_confirmation: current_password) }

  before { sign_in(user) }

  describe 'Viewing security settings' do
    it 'returns HTTP success' do
      get dashboard_account_security_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "Updating the user's password" do
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

    before { patch dashboard_account_security_path, params: params }

    context 'with valid attributes' do
      it 'redirects to the account security page' do
        expect(response).to redirect_to(dashboard_account_security_path)
      end

      it 'updates the password' do
        expect(user.reload).to be_valid_password(new_password)
      end
    end

    context 'with incorrect password' do
      let(:password) { 'incorrect-password' }

      it 'returns HTTP unprocessable entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not update the password' do
        expect(user.reload).not_to be_valid_password(new_password)
      end
    end
  end
end
