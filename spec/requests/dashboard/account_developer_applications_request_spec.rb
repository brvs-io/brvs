# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Developer applications for a user', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:application) { FactoryBot.create(:oauth_application, owner: user) }

  before { sign_in(user) }

  describe 'Listing developer applications' do
    it 'returns HTTP success' do
      get dashboard_account_developer_applications_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'Building a new developer application' do
    it 'returns HTTP success' do
      get new_dashboard_account_developer_application_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'Creating a developer application' do
    let(:name) { Faker::App.name }
    let(:new_application) { Doorkeeper::Application.find_by(name: name) }

    before { post dashboard_account_developer_applications_path, params: params }

    context 'with valid params' do
      let(:params) { { doorkeeper_application: { name: name, redirect_uri: 'https://example.com/callback' } } }

      it 'redirects to the new developer application' do
        expect(response).to redirect_to(dashboard_account_developer_application_path(new_application))
      end

      it 'creates the developer application' do
        expect(new_application).to be_persisted
      end
    end

    context 'with invalid params' do
      let(:params) { { doorkeeper_application: { name: name, redirect_uri: '' } } }

      it 'responds with HTTP unprocessable entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not create the developer application' do
        expect(new_application).to be_nil
      end
    end
  end

  describe 'Viewing a developer application' do
    it 'returns HTTP success' do
      get dashboard_account_developer_application_path(application)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'Updating a developer application' do
    subject(:update_request) { patch dashboard_account_developer_application_path(application), params: params }

    context 'with valid parameters' do
      let(:new_name) { Faker::App.unique.name }
      let(:params) { { doorkeeper_application: { name: new_name } } }

      it 'redirects to the developer application' do
        update_request
        expect(response).to redirect_to(dashboard_account_developer_application_path(application))
      end

      it 'updates the developer application' do
        expect { update_request }.to(change { application.reload.name }.to(new_name))
      end
    end

    context 'with invalid parameters' do
      let(:params) { { doorkeeper_application: { name: '' } } }

      it 'returns HTTP unprocessable entity' do
        update_request
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not update the developer application' do
        expect { update_request }.not_to(change { application.reload.name })
      end
    end
  end

  describe 'Destroying a developer application' do
    before { delete dashboard_account_developer_application_path(application) }

    it 'redirects to the developer applications list' do
      expect(response).to redirect_to(dashboard_account_developer_applications_path)
    end

    it 'deletes the applicatino' do
      expect(Doorkeeper::Application.find_by(id: application)).to be_nil
    end
  end

  describe 'Revoking all access to an application' do
    let(:tokens) { FactoryBot.create_list(:oauth_access_token, 5, application: application) }

    before do
      tokens
      delete revoke_dashboard_account_developer_application_path(application)
    end

    it 'redirects to the developer application' do
      expect(response).to redirect_to(dashboard_account_developer_application_path(application))
    end

    it 'revokes all access tokens for the application' do
      expect(tokens).to(be_all { |t| t.reload.revoked? })
    end
  end

  describe 'Resetting the client secret for a developer application' do
    subject(:reset_client_secret_request) { delete secret_dashboard_account_developer_application_path(application) }

    it 'redirects to the developer application' do
      reset_client_secret_request
      expect(response).to redirect_to(dashboard_account_developer_application_path(application))
    end

    it 'resets the client secret for the application' do
      expect { reset_client_secret_request }.to(change { application.reload.plaintext_secret })
    end
  end
end
