# frozen_string_literal: true

module Dashboard
  # Account profile settings controller.
  class AccountsController < DashboardController
    def update
      if current_user.update(profile_params)
        redirect_to dashboard_account_path, notice: resource_notification_updated
      else
        render :show, status: :unprocessable_entity
      end
    end

    private

    def resource
      current_user
    end

    def resource_notification_updated_key
      'dashboard.accounts.notifications.profile.updated'
    end

    def profile_params
      params.require(:user).permit(:email, :name)
    end
  end
end
