class Post < ApplicationRecord
  belongs_to :user
  validates :user, :title, :content, presence: true
  mount_uploader :photo, PhotoUploader
end
