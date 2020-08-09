# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Homepage', type: :request do
  describe 'Viewing the homepage' do
    it 'returns HTTP success' do
      get '/'
      expect(response).to have_http_status(:ok)
    end
  end
end
