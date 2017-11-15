class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  validates :content, presence: true

end
