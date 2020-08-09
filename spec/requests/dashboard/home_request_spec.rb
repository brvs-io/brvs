# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Dashboard homepage', type: :request do
  let(:user) { FactoryBot.create(:user) }

  before { sign_in(user) }

  describe 'Viewing the dashboard homepage' do
    it 'returns HTTP success' do
      get dashboard_root_path
      expect(response).to have_http_status(:ok)
    end
  end
end
