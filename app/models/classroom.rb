class Classroom < ApplicationRecord
  has_many :children
  has_many :familylinks, through: :children
  has_many :users, through: :familylinks
  validates :name, :signin_code, presence: true
  validates :signin_code, length: { is: 5 }
end
