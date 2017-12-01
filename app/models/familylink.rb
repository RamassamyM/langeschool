class Familylink < ApplicationRecord
  belongs_to :user
  belongs_to :child
  validates :user, :child, :parental_link, presence: true
  validates :user, uniqueness: { scope: :child,
                                 message: 'Un seul lien parent enfant possible' }
  enum parental_link: %i[mère père]
end
