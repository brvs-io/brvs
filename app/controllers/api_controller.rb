# frozen_string_literal: true

# Base class for API controllers.
class APIController < ActionController::API
  include Doorkeeper::Helpers::Controller

  before_action :doorkeeper_authorize!
end
