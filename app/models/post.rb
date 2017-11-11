class Post < ApplicationRecord
  belongs_to :user
  has_many :assets
  validates :user, :title, :content, presence: true

  def assets?
    self.assets.count > 0
  end
end
