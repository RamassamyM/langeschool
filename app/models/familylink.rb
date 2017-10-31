class Familylink < ApplicationRecord
  belongs_to :user
  belongs_to :child
  validates :user, :child, presence: true
end
