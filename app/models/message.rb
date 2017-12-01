class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :notifications, as: :notificable
  validates :content, presence: true
  after_create :conversation_last_update
  after_create_commit { create_message_to_stream_job }
  scope :for_display, -> { order(:created_at).last(50) }

  def conversation_last_update
    self.conversation.last_update = Time.zone.now
  end

  def read
    self.is_read = true
    self.save
  end

  def recipient
    self.author == self.conversation.user1 ? self.conversation.user2 : self.conversation.user1
  end

  private

  def create_message_to_stream_job
    MessageBroadcastJob.perform_later self
  end
end
