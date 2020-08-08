# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'LinksController', type: :request do
  context 'with existing link' do
    let(:link) { FactoryBot.create(:link) }

    describe 'GET /:id' do
      it 'redirects to the target of the link' do
        get "/#{link.name}"
        expect(response).to redirect_to(link.target)
      end
    end
  end

  context 'with nonexistent link' do
    describe 'GET /:id' do
      it 'returns HTTP not found' do
        get '/nonexistent-link'
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
