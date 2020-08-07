# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Dashboard::HomeController', type: :request do
  let(:user) { FactoryBot.create(:user) }

  before { sign_in(user) }

  describe 'GET /dashboard' do
    it 'returns HTTP success' do
      get '/dashboard'
      expect(response).to have_http_status(:ok)
    end
  end
end
