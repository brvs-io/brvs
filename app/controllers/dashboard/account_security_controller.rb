# frozen_string_literal: true

module Dashboard
  # Account security settings controller.
  class AccountSecurityController < DashboardController
    def update
      if resource.update_with_password(password_params)
        redirect_to dashboard_account_security_path, notice: resource_notification_updated
      else
        render :show, status: :unprocessable_entity
      end
    end

    private

    def resource
      current_user
    end

    def resource_notification_updated_key
      'dashboard.accounts.notifications.password.updated'
    end

    def password_params
      params.require(:user).permit(:current_password, :password, :password_confirmation)
    end
  end
end
