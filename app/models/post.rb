class Post < ApplicationRecord
  belongs_to :user
  has_many :assets
  validates :user, :title, :content, presence: true
end
