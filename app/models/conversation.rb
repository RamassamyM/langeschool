class Conversation < ApplicationRecord
  belongs_to :user1, class_name: 'User', foreign_key: 'user1_id'
  belongs_to :user2, class_name: 'User', foreign_key: 'user2_id'
  has_many :messages

  validates :user1_id, uniqueness: { scope: :user2_id }
  validates :last_update, presence: true
  before_validation :ensure_user2_bigger_than_user1
  before_validation :set_last_update

  def ensure_user2_bigger_than_user1
    user2.id > user1.id
  end

end
