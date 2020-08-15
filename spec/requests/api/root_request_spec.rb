# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Root API', type: :request do
  path '/api' do
    get 'Retrieves API information and status' do
      produces 'application/json'
      security [{ oauth2: [] }]

      response '200', 'API available' do
        let(:Authorization) { "Bearer #{FactoryBot.create(:oauth_access_token).token}" } # rubocop:disable RSpec/VariableName
        run_test!
      end
    end
  end
end
