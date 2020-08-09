# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Dashboard::AccountProfilesController', type: :request do
  let(:user) { FactoryBot.create(:user) }

  before { sign_in(user) }

  describe 'PATCH /dashboard/user' do
    subject(:update_account_request) do
      patch '/dashboard/user', params: params
    end

    let(:params) { { user: { name: new_name, email: new_email } } }

    context 'with valid attributes' do
      let(:new_name) { Faker::Name.name }
      let(:new_email) { Faker::Internet.email }

      it 'redirects to the account page' do
        update_account_request
        expect(response).to redirect_to(dashboard_account_profile_path)
      end

      it 'updates the current user name' do
        expect { update_account_request }.to change { user.reload.name }.to(new_name)
      end

      it 'updates the current user email' do
        expect { update_account_request }.to change { user.reload.unconfirmed_email }.to(new_email)
      end
    end

    context 'with invalid attributes' do
      let(:new_name) { '' }
      let(:new_email) { 'not-an-email' }

      it 'responds with HTTP unprocessable entity' do
        update_account_request
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not update the record' do
        expect { update_account_request }.not_to(change { user.reload.updated_at })
      end
    end
  end
end
