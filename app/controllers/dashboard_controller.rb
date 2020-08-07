# frozen_string_literal: true

# Base class for dashboard controllers
class DashboardController < ApplicationController
  include ResourceNotifications

  before_action :authenticate_user!
end
