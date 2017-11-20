class Child < ApplicationRecord
  belongs_to :classroom
  has_many :familylinks
  has_many :users, through: :familylinks
  validates :first_name, :classroom, presence: true
end
