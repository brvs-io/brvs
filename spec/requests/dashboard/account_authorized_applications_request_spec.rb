# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Authorized applications for a user', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:first_application) { FactoryBot.create(:oauth_application) }
  let(:second_application) { FactoryBot.create(:oauth_application) }

  before do
    FactoryBot.create(:oauth_access_token, resource_owner: user, application: first_application)
    FactoryBot.create(:oauth_access_token, resource_owner: user, application: second_application)

    sign_in(user)
  end

  describe 'Listing authorized applications' do
    it 'returns HTTP success' do
      get '/dashboard/user/applications/authorized'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'Viewing a single authorized application' do
    it 'returns HTTP success' do
      get "/dashboard/user/applications/authorized/#{first_application.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'Revoking all access' do
    before { delete '/dashboard/user/applications/authorized/revoke-all' }

    it 'redirects to the authorized applications page' do
      expect(response).to redirect_to(dashboard_account_authorized_applications_path)
    end

    it "revokes all of the logged in user's access tokens" do
      expect(user.access_tokens.all).to be_all(&:revoked?)
    end
  end

  describe 'Revoking access for a single application' do
    before { delete "/dashboard/user/applications/authorized/#{first_application.id}" }

    it 'redirects to the authorized applications page' do
      expect(response).to redirect_to(dashboard_account_authorized_applications_path)
    end

    it "revokes all of the logged in user's access tokens for the application" do
      expect(user.access_tokens.where(application_id: first_application.id)).to be_all(&:revoked?)
    end
  end
end
