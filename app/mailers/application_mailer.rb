# frozen_string_literal: true

# Base class for mailers.
class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('MAILER_SENDER', 'noreply@example.com')
  layout 'mailer'
end
