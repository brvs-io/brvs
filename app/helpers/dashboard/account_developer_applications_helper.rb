# frozen_string_literal: true

module Dashboard
  # Helpers for account developer applications views.
  module AccountDeveloperApplicationsHelper
    def developer_application_active_users_count(application)
      @developer_application_active_users_count ||= application.access_tokens
                                                               .where(revoked_at: nil)
                                                               .distinct.count(:resource_owner_id)
    end
  end
end
