# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Link management', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:link) { FactoryBot.create(:link, owner: user) }
  let(:other_link) { FactoryBot.create(:link) }

  before do
    sign_in(user)
  end

  describe 'Listing links' do
    it 'returns HTTP success' do
      get dashboard_links_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'Building a new link' do
    it 'returns HTTP success' do
      get new_dashboard_link_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'Creating a link' do
    before { post dashboard_links_path, params: params }

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

  describe 'Viewing a link' do
    it 'returns HTTP success' do
      get dashboard_link_path(link)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'Editing a link' do
    it 'returns HTTP success' do
      get edit_dashboard_link_path(link)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'Updating a link' do
    before { patch dashboard_link_path(link), params: params }

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

  describe 'Deleting a link' do
    before { delete dashboard_link_path(link) }

    it 'destroys the link' do
      expect(Link.find_by(id: link)).to be_nil
    end

    it 'redirects to the index page' do
      expect(response).to redirect_to(dashboard_links_path)
    end
  end
end
