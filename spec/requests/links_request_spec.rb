# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Link redirection', type: :request do
  describe 'Retrieving a link' do
    context 'with existing link' do
      let(:link) { FactoryBot.create(:link) }

      it 'redirects to the target of the link' do
        get link_path(link.name)
        expect(response).to redirect_to(link.target)
      end
    end

    context 'with nonexistent link' do
      it 'returns HTTP not found' do
        get link_path('/nonexistent-link')
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
