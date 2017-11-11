class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable
  has_many :familylinks
  has_many :children, through: :familylinks
  has_many :classrooms, through: :children
  has_many :posts
  has_many :author_messages, class_name: 'Message', foreign_key: 'author_id'
  has_many :recipient_messages, class_name: 'Message', foreign_key: 'recipient_id'
  validates :first_name, :last_name, presence: true

  def fullname
    self.first_name + " " + self.last_name
  end
end
