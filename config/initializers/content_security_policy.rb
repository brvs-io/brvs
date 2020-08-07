# frozen_string_literal: true

# https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy
Rails.application.config.content_security_policy do |policy|
  policy.default_src :self, :https
  policy.font_src    :self, :https, :data
  policy.img_src     :self, :https, :data
  policy.object_src  :none
  policy.script_src  :self, :https
  policy.style_src   :self, :https

  policy.connect_src :self, :https, 'http://localhost:3035', 'ws://localhost:3035' if Rails.env.development?

  policy.report_uri '/csp-violation-report-endpoint' if ENV['CSP_VIOLATION_REPORT_ENDPOINT']
end

Rails.application.config.content_security_policy_nonce_generator = ->(_request) { SecureRandom.base64(16) }
Rails.application.config.content_security_policy_nonce_directives = %w[script-src]
