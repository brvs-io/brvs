# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Link redirection', type: :request do
  describe 'Building a new link' do
    it 'returns HTTP success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'Retrieving a link' do
    context 'when on the default domain with an existing link' do
      let(:link) { FactoryBot.create(:link) }

      it 'redirects to the target of the link' do
        get link_path(link.name)
        expect(response).to redirect_to(link.target)
      end
    end

    context 'when on the default domain with a nonexistent link' do
      it 'returns HTTP not found' do
        get link_path('/nonexistent-link')
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when on the default domain with a link on another domain' do
      let(:link) { FactoryBot.create(:link, :with_domain) }

      it 'returns HTTP not found' do
        get link_path(link.name)
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when on another domain with an existing link' do
      let(:link) { FactoryBot.create(:link, :with_domain) }

      before { self.host = link.domain.name }

      it 'redirects to the target of the link' do
        get link_path(link.name)
        expect(response).to redirect_to(link.target)
      end
    end

    context 'when on another domain with an nonexistent link' do
      let(:domain) { FactoryBot.create(:domain) }

      before { self.host = domain.name }

      it 'redirects to the target of the link' do
        get link_path('/nonexistent-link')
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
