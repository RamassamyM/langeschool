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

  has_many :user1_conversations, class_name: 'Conversation', foreign_key: 'user1_id'
  has_many :user2_conversations, class_name: 'Conversation', foreign_key: 'user2_id'

  has_many :author_messages, class_name: 'Message', foreign_key: 'author_id'

  has_attachment :avatar

  validates :first_name, :last_name, presence: true

  def fullname
    self.first_name + " " + self.last_name
  end

  def name
    "#{first_name} #{last_name}"
  end

  def conversations
    (self.user1_conversations + self.user2_conversations).sort{|a,b| a.last_update <=> b.last_update }
  end

  # def unreadmessages(conversation)
  #   conversation.messages.where(:author != self).where(is_read == false).order(:created_at)
  # end

  def conversations_partners
    self.user1_conversations.pluck(:user2) + self.user2_conversations.pluck(:user1)
  end

end
