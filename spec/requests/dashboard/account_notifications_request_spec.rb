# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Account notification settings', type: :request do
  let(:user) { FactoryBot.create(:user) }

  before { sign_in(user) }

  describe 'Showing notification settings' do
    it 'returns HTTP success' do
      get dashboard_account_notifications_path
      expect(response).to have_http_status(:success)
    end
  end
end
