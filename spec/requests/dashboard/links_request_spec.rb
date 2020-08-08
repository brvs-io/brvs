# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Dashboard::LinksController', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:link) { FactoryBot.create(:link, owner: user) }
  let(:other_link) { FactoryBot.create(:link) }

  before do
    sign_in(user)
  end

  describe 'GET /dashboard/links' do
    it 'returns HTTP success' do
      get '/dashboard/links'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /dashboard/links/new' do
    it 'returns HTTP success' do
      get '/dashboard/links/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /dashboard/links' do
    before { post '/dashboard/links', params: params }

    context 'with valid params' do
      let(:params) { { link: { target: Faker::Internet.url } } }
      let(:new_link) { user.links.find_by(target: params[:link][:target]) }

      it 'creates the new link' do
        expect(new_link).to be_persisted
      end

      it 'redirects to the new link' do
        expect(response).to redirect_to(dashboard_link_path(new_link))
      end
    end

    context 'with invalid params' do
      let(:params) { { link: { target: '' } } }

      it 'returns HTTP unprocessable entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET /dashboard/links/:id' do
    it 'returns HTTP success' do
      get "/dashboard/links/#{link.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /dashboard/links/:id/edit' do
    it 'returns HTTP success' do
      get "/dashboard/links/#{link.id}/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH /dashboard/links/:id' do
    before { patch "/dashboard/links/#{link.id}", params: params }

    context 'with valid params' do
      let(:new_target) { Faker::Internet.url }
      let(:params) { { link: { target: new_target } } }

      it 'updates the link' do
        expect(link.reload.target).to eq(new_target)
      end

      it 'redirects to the link' do
        expect(response).to redirect_to(dashboard_link_path(link))
      end
    end

    context 'with invalid params' do
      let(:new_target) { 'bad-target' }
      let(:params) { { link: { target: new_target } } }

      it 'does not update the link' do
        expect(link.reload.target).not_to eq(new_target)
      end

      it 'returns HTTP unprocessable entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DESTROY /dashboard/links/:id' do
    before { delete "/dashboard/links/#{link.id}" }

    it 'destroys the link' do
      expect(Link.find_by(id: link)).to be_nil
    end

    it 'redirects to the index page' do
      expect(response).to redirect_to(dashboard_links_path)
    end
  end
end
