# frozen_string_literal: true

# Controller to manage links and redirects them to their targets.
class LinksController < ApplicationController
  layout 'home'

  def show
    link = Link.find_by(name: params[:id])
    if link.present?
      redirect_to URI.parse(link.target).to_s, status: :moved_permanently
    else
      render :not_found, status: :not_found
    end
  end
end
