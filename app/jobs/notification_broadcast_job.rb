class NotificationBroadcastJob < ApplicationJob
  queue_as :default

  def perform(notification)
    ActionCable.server.broadcast \
      "web_notifications_#{notification.user.id}", increment: 1
  end
end
