class Familylink < ApplicationRecord
  belongs_to :user
  belongs_to :child
  validates :user, :child, :parental_link, presence: true
  enum parental_link: %i(mère père)
end
