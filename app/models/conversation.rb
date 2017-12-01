class Conversation < ApplicationRecord
  belongs_to :user1, class_name: 'User', foreign_key: 'user1_id'
  belongs_to :user2, class_name: 'User', foreign_key: 'user2_id'
  has_many :messages
  validates :user1_id, uniqueness: { scope: :user2_id }
  validates :last_update, presence: true
  before_validation :ensure_user2_bigger_than_user1
  before_validation :set_last_update
  scope :for_display, -> { order("conversations.last_update at DESC").last(30) }

  def ensure_user2_bigger_than_user1
    if user2.id <= user1.id
      errors.add(:user2,
                'Le user2_id doit être différent et plus grand que le user1_id')
    end
  end

  def set_last_update
    self.last_update = Time.zone.now unless self.last_update
  end

end
