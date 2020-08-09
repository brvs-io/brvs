# frozen_string_literal: true

module Dashboard
  # Account developer applications controller.
  class AccountDeveloperApplicationsController < DashboardController
    layout 'dashboard/accounts'

    before_action :find_application, only: %i[show update revoke secret destroy]

    def index
      @applications = current_user.developer_applications.order(:name)
    end

    def new
      @application = Doorkeeper::Application.new
    end

    def create
      @application = current_user.developer_applications.build(application_params)
      if @application.save
        redirect_to dashboard_account_developer_application_path(@application)
      else
        render :new, status: :unprocessable_entity
      end
    end

    def show; end

    def update
      if @application.update(application_params)
        redirect_to dashboard_account_developer_application_path(@application)
      else
        render :show, status: :unprocessable_entity
      end
    end

    def revoke
      Doorkeeper::AccessToken.where(application_id: @application.id).each(&:revoke)
      redirect_to dashboard_account_developer_application_path(@application)
    end

    def secret
      @application.renew_secret
      @application.save
      redirect_to dashboard_account_developer_application_path(@application)
    end

    def destroy
      @application.destroy
      redirect_to dashboard_account_developer_applications_path
    end

    private

    def application_params
      params.require(:doorkeeper_application).permit(:name, :redirect_uri)
    end

    def find_application
      @application = current_user.developer_applications.find(params[:id])
    end
  end
end
