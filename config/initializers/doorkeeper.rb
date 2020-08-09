# frozen_string_literal: true

ALL_SCOPES = %w[
  links:read
  links:write
  users:applications:read
  users:applications:write
  users:profile:read
  users:profile:write
].freeze
DEFAULT_SCOPES = %w[
].freeze

Doorkeeper.configure do
  orm :active_record

  resource_owner_authenticator do
    current_user || warden.authenticate!(scope: :user)
  end

  use_polymorphic_resource_owner

  # Enforce token request content type to application/x-www-form-urlencoded
  enforce_content_type

  # Authorization Code expiration time
  authorization_code_expires_in(Rails.env.development? ? 24.hours : 10.minutes)

  # Access token expiration time
  access_token_expires_in(Rails.env.development? ? 24.hours : 2.hours)

  # Issue access tokens with refresh token.
  use_refresh_token

  # Support application ownership
  enable_application_owner confirmation: false

  # Access scopes
  default_scopes(*DEFAULT_SCOPES)
  optional_scopes(*(ALL_SCOPES - DEFAULT_SCOPES))

  # Forbids creating/updating applications with arbitrary scopes that are
  # not in configuration, i.e. +default_scopes+ or +optional_scopes+.
  enforce_configured_scopes

  # before_successful_strategy_response do |request|
  # end

  # after_successful_strategy_response do |request, response|
  # end

  # before_successful_authorization do |controller, context|
  #   Rails.logger.info(controller.request.params.inspect)
  #   Rails.logger.info(context.pre_auth.inspect)
  # end

  # after_successful_authorization do |controller, context|
  #   Rails.logger.info(context.auth.inspect)
  #   Rails.logger.info(context.issued_token)
  # end

  # WWW-Authenticate realm
  realm 'Brvs'
end
