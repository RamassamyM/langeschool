class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  validates :content, presence: true
  after_create :conversation_last_update

  def conversation_last_update
    self.conversation.last_update = Time.zone.now
  end

  def read
    self.is_read = true
    self.save
  end

end
