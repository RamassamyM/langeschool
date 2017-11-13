class Post < ApplicationRecord
  belongs_to :user
  validates :user, :title, :content, presence: true
  has_attachments :photos, maximum: 5
end
