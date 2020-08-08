# frozen_string_literal: true

# Base class for controllers.
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def resource
    raise NotImplementedError, 'Must implement in subclass'
  end
  helper_method :resource

  def resource_errors_key
    'notifications.application.errors'
  end
  helper_method :resource_errors_key

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || dashboard_root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
