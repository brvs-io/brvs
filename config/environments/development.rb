# frozen_string_literal: true

Rails.application.configure do # rubocop:disable Metrics/BlockLength
  # General Rails configuration
  config.cache_classes = false
  config.consider_all_requests_local = true
  config.eager_load = false

  # Host authorization configuration
  config.hosts << '.lvh.me'
  config.hosts << '.ngrok.io'
  config.hosts << '.test'
  config.hosts << config.x.default_domain

  # Caching configuration
  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false
    config.cache_store = :null_store
  end

  # ActionMailer configuration
  config.action_mailer.default_url_options = { host: 'localhost', port: ENV.fetch('PORT', 5000) }
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_caching = false

  # ActionView configuration
  config.action_view.raise_on_missing_translations = true

  # ActiveSupport configuration
  config.active_support.deprecation = :log

  # ActiveRecord configuration
  config.active_record.migration_error = :page_load
  config.active_record.verbose_query_logs = true

  # File watcher configuration
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker
end
