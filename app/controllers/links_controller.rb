# frozen_string_literal: true

# Controller to manage links and redirects them to their targets.
class LinksController < ApplicationController
  layout 'home'

  before_action :authenticate_user!, only: %i[new create]

  def show
    @link = default_domain? ? find_link_on_default_domain : find_link_on_domain
    redirect_or_not_found(@link)
  end

  def new
    @link = current_user.links.new(target: new_params[:target])
    @link.save if params[:auto]
  end

  private

  def find_link_on_default_domain
    Link.on_default_domain.find_by(name: params[:id])
  end

  def find_link_on_domain
    domain = Domain.find_by(name: request.domain)
    render_not_found if domain.blank?

    domain.links.find_by(name: params[:id])
  end

  def redirect_or_not_found(link)
    if link.present?
      redirect_to URI.parse(link.target).to_s, status: :moved_permanently
    else
      render_not_found
    end
  end

  def render_not_found
    render :not_found, status: :not_found
  end

  def default_domain?
    request.domain == Rails.configuration.x.default_domain
  end

  def new_params
    params.permit(:target)
  end
end
