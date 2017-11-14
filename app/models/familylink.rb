class Familylink < ApplicationRecord
  belongs_to :user
  belongs_to :child
  validates :user, :child, :parental_link, presence: true
end
