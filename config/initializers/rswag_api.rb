# frozen_string_literal: true

Rswag::Api.configure do |c|
  c.swagger_root = Rails.root.join('api/openapi')

  # Inject a lamda function to alter the returned Swagger prior to serialization
  # The function will have access to the rack env for the current request
  # For example, you could leverage this to dynamically assign the "host" property
  #
  # c.swagger_filter = lambda { |swagger, env| swagger['host'] = env['HTTP_HOST'] }
end
