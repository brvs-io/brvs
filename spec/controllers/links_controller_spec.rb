# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LinksController, type: :controller do
  let(:user) { FactoryBot.create(:user) }

  describe 'GET #new' do
    before { sign_in(user) }

    context 'with no parameters' do
      it 'builds an empty link' do
        get :new
        expect(assigns[:link].target).to be_nil
      end
    end

    context 'with a target parameter' do
      let(:target) { Faker::Internet.url }

      it 'prefills the target on the new link' do
        get :new, params: { target: target }
      end
    end

    context 'with target and auto parameters' do
      let(:target) { Faker::Internet.url }

      it 'automatically creates a new link' do
        get :new, params: { target: target, auto: 'true' }
        expect(assigns(:link)).to be_persisted
      end
    end
  end
end
