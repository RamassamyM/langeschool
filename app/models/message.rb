class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  validates :author, :conversation, :content, presence: true
  scope :read, -> { where(is_read: true)}
  scope :unread, -> {where(is_read: false)}
  scope :lastpublished, -> (limit = 20, offset = 0) { order(created_at: :desc).limit(limit).offset(offset) }

  def has_read
    self.read = true
    self.save
  end

end
