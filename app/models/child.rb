class Child < ApplicationRecord
  belongs_to :classroom
  has_many :familylinks, dependent: :destroy
  has_many :users, through: :familylinks
  validates :first_name, :classroom, presence: { message: "Information requise" }
  validates :first_name, uniqueness: { scope: :last_name }
  validates_format_of :first_name,
                      :last_name,
                      :with => /\A[A-z\u00C0-\u00ff][A-z\-' \u00C0-\u00ff]{0,23}[A-z\u00C0-\u00ff]\z/u,
                      :on => :create,
                      message: "25 lettres ou caractères de séparation seulement."
end
