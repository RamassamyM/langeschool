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
  validates :first_name, :last_name, presence: true
  has_attachment :avatar
  has_many :participantlinks
  has_many :conversations, through: :participantlinks

  def fullname
    self.first_name + " " + self.last_name
  end

  def name
    "#{first_name} #{last_name}"
  end

  # def allmessages
  #   Message.where(author: self).or(Message.where(recipient: self)).order(:creates_at)
  # end

  # def unreadmessages
  #   self.author_messages.where(read: false).order(:created_at)
  # end

  # def readmessages
  #   self.author_messages.where(read: true).order(:created_at)
  # end

  # def interlocutors
  #   self.author_messages.group(:recipient)
  # end

end
