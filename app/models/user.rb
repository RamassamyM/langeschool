class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable
  has_many :familylinks
  has_many :children, through: :familylinks
  has_many :posts
  validates :first_name, :last_name, :parent_type, presence: true
end
