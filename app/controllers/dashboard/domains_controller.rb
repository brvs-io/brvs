# frozen_string_literal: true

module Dashboard
  # Manages domains.
  class DomainsController < DashboardController
    before_action :find_domain, only: %i[show edit update destroy]

    def index
      @domains = current_user.domains.order(created_at: :desc).page(params[:page])
    end

    def new
      @domain = Domain.new
    end

    def create
      @domain = current_user.domains.build(domain_params)
      if @domain.save
        redirect_to dashboard_domain_path(@domain), notice: resource_notification_created
      else
        @domain.name = nil
        render :new, status: :unprocessable_entity
      end
    end

    def show; end

    def edit; end

    def update
      if @domain.update(domain_params)
        redirect_to dashboard_domain_path(@domain), notice: resource_notification_updated
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @domain.destroy
      redirect_to dashboard_domains_path, notice: resource_notification_destroyed
    end

    private

    def domain_params
      params = ActionController::Parameters.new(request.request_parameters)
      params.require(:domain).permit(:name)
    end

    def find_domain
      @domain = current_user.domains.find(params[:id])
    end

    def resource
      @domain
    end
  end
end
