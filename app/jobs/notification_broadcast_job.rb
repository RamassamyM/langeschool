class NotificationBroadcastJob < ApplicationJob
  queue_as :default

  def perform(notification)
    ActionCable.server.broadcast \
      "web_notifications_#{notification.user.id}",
      { notification_message: notification.notification_message,
        notificable_type: notification[:notificable_type],
        is_seen: notification.is_seen,
        notificable_id: notification.notificable_id,
        avatar_url: "http://res.cloudinary.com/langeconnect/image/upload/\
                     #{notification.user.avatar.path}" }
  end
end
