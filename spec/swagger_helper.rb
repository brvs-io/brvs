# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  config.swagger_root = Rails.root.join('api/openapi').to_s
  config.swagger_docs = {
    'v1/openapi.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'Brvs REST API v1',
        version: 'v1'
      },
      components: {
        securitySchemes: {
          oauth2: {
            type: :oauth2,
            flows: {
              authorizationCode: {
                authorizationUrl: 'https://{defaultHost}/oauth2/authorize',
                tokenUrl: 'https://{defaultHost}/oauth2/token',
                refreshUrl: 'https://{defaultHost}/oauth2/token',
                scopes: {
                  'users:read': 'Read user profile information'
                }
              }
            }
          }
        }
      },
      paths: {},
      servers: [
        {
          url: 'https://{defaultHost}',
          variables: {
            defaultHost: {
              default: 'www.example.com'
            }
          }
        }
      ]
    }
  }

  config.swagger_format = :yaml
end
