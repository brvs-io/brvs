# frozen_string_literal: true

require_relative 'boot'

require 'rails'
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'

Bundler.require(*Rails.groups)

module Brvs
  # The Rails application.
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # ActiveJob configuration
    config.active_job.queue_adapter = :delayed_job

    # Generator configuration
    config.generators.system_tests = nil

    # I18n configuration
    config.i18n.available_locales = %i[en]
    config.i18n.load_path += Dir[Rails.root.join('config/locales/**/*.{rb,yml}')]

    # Brvs configuration
    config.x.default_domain = ENV.fetch('BRVS_DEFAULT_DOMAIN', 'example.com')
  end
end
