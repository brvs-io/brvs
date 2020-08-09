# frozen_string_literal: true

module Dashboard
  # Dashboard controller to manage links.
  class LinksController < DashboardController
    before_action :find_link, only: %i[show edit update destroy]

    def index
      @links = current_user.links.order(created_at: :desc).page(params[:page])
    end

    def new
      @link = Link.new
    end

    def create
      @link = current_user.links.build(link_params)
      if @link.save
        redirect_to dashboard_link_path(@link), notice: resource_notification_created
      else
        @link.name = nil
        render :new, status: :unprocessable_entity
      end
    end

    def show; end

    def edit; end

    def update
      if @link.update(link_params)
        redirect_to dashboard_link_path(@link), notice: resource_notification_updated
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @link.destroy
      redirect_to dashboard_links_path, notice: resource_notification_destroyed
    end

    private

    def link_params
      params.require(:link).permit(:name, :target, :expires_in, :tag_names, :notes, :domain_id)
    end

    def find_link
      @link = current_user.links.find(params[:id])
    end

    def resource
      @link
    end
  end
end
