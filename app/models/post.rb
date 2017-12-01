class Post < ApplicationRecord
  belongs_to :user
  validates :user, :title, :content, presence: { message: "Information requise" }
  has_many :notifications, as: :notficable
  has_attachments :photos, maximum: 5

  #TODO : remove foreign key, as posts main remain even if the author is deleted
  # and add a author_name column, let just admin users crud posts
end
