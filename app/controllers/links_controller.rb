# frozen_string_literal: true

# Controller to manage links and redirects them to their targets.
class LinksController < ApplicationController
  layout 'home'

  def show
    @link = default_domain? ? find_link_on_default_domain : find_link_on_domain
    redirect_or_not_found(@link)
  end

  private

  def find_link_on_default_domain
    Link.on_default_domain.find_by(name: params[:id])
  end

  def find_link_on_domain
    domain = Domain.find_by(name: request.domain)
    domain&.links&.find_by(name: params[:id]) if domain.present?
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
    request.host == Rails.configuration.x.default_domain
  end
end
