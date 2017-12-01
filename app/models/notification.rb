class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :notificable, polymorphic: true
  validates :user, uniqueness: { scope: %i[notificable_type notificable_id] }
  validates :notification_message, presence: true
  after_create_commit { create_message_notification_to_stream_job }
  scope :unseen, -> { where(is_seen: false).order(:created_at) }
  scope :lastseen, -> { where(is_seen: true).order(:created_at).last(5) }

  def seen
    self.update(is_seen: true)
  end

  private

  def create_message_notification_to_stream_job
    NotificationBroadcastJob.perform_later self
  end
end
