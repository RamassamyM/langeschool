class Familylink < ApplicationRecord
  belongs_to :user
  belongs_to :child
end
