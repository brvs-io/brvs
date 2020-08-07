# frozen_string_literal: true

Devise.setup do |config| # rubocop:disable Metrics/BlockLength
  require 'devise/orm/active_record'

  # Mailer configuration
  config.mailer = 'UserMailer'
  config.mailer_sender = ENV.fetch('MAILER_SENDER', 'noreply@example.com')

  # Authentication configuration
  config.case_insensitive_keys = %i[email]
  config.strip_whitespace_keys = %i[email]
  config.paranoid = true
  config.skip_session_storage = %i[http_auth]

  # Database authentication configuration
  config.stretches = Rails.env.test? ? 1 : 12
  config.pepper = ENV.fetch('DEVISE_PEPPER')
  config.send_email_changed_notification = true
  config.send_password_change_notification = true

  # Email confirmation configuration
  config.allow_unconfirmed_access_for = 2.days
  config.confirm_within = 3.days
  config.reconfirmable = true

  # Rememberable configuration
  config.remember_for = 2.weeks
  config.expire_all_remember_me_on_sign_out = true

  # Validation configuration
  config.password_length = 6..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/

  # Lockable configuration
  config.lock_strategy = :failed_attempts
  config.unlock_strategy = :both
  config.maximum_attempts = 20
  config.unlock_in = 1.hour
  config.last_attempt_warning = true

  # Recoverable configuration
  config.reset_password_within = 6.hours
  config.sign_in_after_reset_password = false

  # Navigation configuration
  config.sign_out_via = :delete

  # Turbolinks configuration
  ActiveSupport.on_load(:devise_failure_app) do
    include Turbolinks::Controller
  end

  # Registerable configuration
  config.sign_in_after_change_password = false
end
