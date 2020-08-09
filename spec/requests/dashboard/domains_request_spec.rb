# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Domain management', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:domain) { FactoryBot.create(:domain, owner: user) }

  before { sign_in(user) }

  describe 'Listing domains' do
    it 'returns HTTP success' do
      get dashboard_domains_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'Building a new domain' do
    it 'returns HTTP success' do
      get new_dashboard_domain_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'Creating a domain' do
    before { post dashboard_domains_path, params: params }

    context 'with valid params' do
      let(:params) { { domain: { name: Faker::Internet.unique.domain_name } } }
      let(:new_domain) { user.domains.find_by(name: params[:domain][:name]) }

      it 'creates the new domain' do
        expect(new_domain).to be_persisted
      end

      it 'redirects to the new domain' do
        expect(response).to redirect_to(dashboard_domain_path(new_domain))
      end
    end

    context 'with invalid params' do
      let(:params) { { domain: { name: '' } } }

      it 'returns HTTP unprocessable entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'Viewing a domain' do
    it 'returns HTTP success' do
      get dashboard_domain_path(domain)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'Editing a domain' do
    it 'returns HTTP success' do
      get edit_dashboard_domain_path(domain)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'Updating a domain' do
    before { patch dashboard_domain_path(domain), params: params }

    context 'with valid params' do
      let(:new_name) { Faker::Internet.unique.domain_name }
      let(:params) { { domain: { name: new_name } } }

      it 'updates the domain' do
        expect(domain.reload.name).to eq(new_name)
      end

      it 'redirects to the domain' do
        expect(response).to redirect_to(dashboard_domain_path(domain))
      end
    end

    context 'with invalid params' do
      let(:new_name) { '#*%bad-@#$name' }
      let(:params) { { domain: { name: new_name } } }

      it 'does not update the domain' do
        expect(domain.reload.name).not_to eq(new_name)
      end

      it 'returns HTTP unprocessable entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'Deleting a domain' do
    before { delete dashboard_domain_path(domain) }

    it 'destroys the domain' do
      expect(Domain.find_by(id: domain.id)).to be_nil
    end

    it 'redirects to the index page' do
      expect(response).to redirect_to(dashboard_domains_path)
    end
  end
end
