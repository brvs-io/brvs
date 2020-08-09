# frozen_string_literal: true

module Dashboard
  # Account authorized application settings controller.
  class AccountAuthorizedApplicationsController < DashboardController
    layout 'dashboard/accounts'

    before_action :find_application, only: %i[show destroy]

    def index
      @applications = Doorkeeper::Application.authorized_for(current_user)
    end

    def show
      @scopes = Doorkeeper::AccessToken.active_for(current_user)
                                       .where(application_id: @application.id)
                                       .map(&:scopes).map(&:to_a).flatten.uniq
    end

    def destroy
      Doorkeeper::AccessToken.revoke_all_for(@application.id, current_user)
      redirect_to dashboard_account_authorized_applications_path
    end

    def revoke_all
      Doorkeeper::AccessToken.active_for(current_user).map(&:revoke)
      redirect_to dashboard_account_authorized_applications_path
    end

    private

    def find_application
      @application = Doorkeeper::Application.authorized_for(current_user).find(params[:id])
    end
  end
end
