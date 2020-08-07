# frozen_string_literal: true

# Provides consistent I18n lookups for notifications on resource changes.
module ResourceNotifications
  extend ActiveSupport::Concern
  def resource_notification_created_key
    'application.notifications.created'
  end

  def resource_notification_destroyed_key
    'application.notifications.destroyed'
  end

  def resource_notification_updated_key
    'application.notifications.updated'
  end

  def resource_notification_created
    t(resource_notification_created_key, resource: resource.class.model_name.human)
  end

  def resource_notification_destroyed
    t(resource_notification_destroyed_key, resource: resource.class.model_name.human)
  end

  def resource_notification_updated
    t(resource_notification_updated_key, resource: resource.class.model_name.human)
  end
end
