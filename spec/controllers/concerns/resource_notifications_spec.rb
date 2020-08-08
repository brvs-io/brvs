# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ResourceNotifications, type: :controller do
  controller(ApplicationController) do
    include ResourceNotifications # rubocop:disable RSpec/DescribedClass

    def create
      flash[:notice] = resource_notification_created
    end

    def destroy
      flash[:notice] = resource_notification_destroyed
    end

    def update
      flash[:notice] = resource_notification_updated
    end
  end

  let(:resource) { FactoryBot.create(:user) }

  before do
    routes.draw do
      post 'create', to: 'anonymous#create'
      delete 'destroy', to: 'anonymous#destroy'
      patch 'update', to: 'anonymous#update'
    end

    allow(controller).to receive(:resource).and_return(resource)
  end

  describe '#resource_notification_created' do
    it 'sets the notice from the current locale' do
      post :create
      expect(request.flash[:notice]).to eq(I18n.t('notifications.application.created', resource: 'User'))
    end
  end

  describe '#resource_notification_destroyed' do
    it 'sets the notice from the current locale' do
      delete :destroy
      expect(request.flash[:notice]).to eq(I18n.t('notifications.application.destroyed', resource: 'User'))
    end
  end

  describe '#resource_notification_updated' do
    it 'sets the notice from the current locale' do
      patch :update
      expect(request.flash[:notice]).to eq(I18n.t('notifications.application.updated', resource: 'User'))
    end
  end
end
