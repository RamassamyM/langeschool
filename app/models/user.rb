class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  #TODO : dependent destroy for familylinks and a callback after destroy user
  # which will destroy children linked do user : the best is forbide destroy
  # and add a field active in user so no post refactoring : change controller

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable

  has_many :familylinks, dependent: :destroy
  accepts_nested_attributes_for :familylinks
  has_many :children, through: :familylinks
  accepts_nested_attributes_for :children

  has_many :classrooms, through: :children
  has_many :posts
  has_many :user1_conversations, class_name: 'Conversation', foreign_key: 'user1_id'
  has_many :user2_conversations, class_name: 'Conversation', foreign_key: 'user2_id'
  has_many :author_messages, class_name: 'Message', foreign_key: 'author_id', dependent: :nullify
  has_many :notifications, dependent: :destroy
  has_attachment :avatar

  validates :first_name, :last_name, presence: { message: "Information requise" }
  validates_format_of :first_name,
                      :last_name,
                      :with => /\A[A-z\u00C0-\u00ff][A-z\-' \u00C0-\u00ff]{0,23}[A-z\u00C0-\u00ff]\z/u,
                      :on => :create,
                      message: "25 lettres ou caractères de séparation seulement."
  def fullname
    self.first_name + " " + self.last_name
  end

  def name
    "#{first_name} #{last_name}"
  end

  def conversations
    # (self.user1_conversations + self.user2_conversations).sort{|a,b| a.last_update <=> b.last_update }
    Conversation.where(user1: self).or(Conversation.where(user2: self)).order(last_update: :desc).last(30)
  end

  def conversations_partners
    self.user1_conversations.pluck(:user2) + self.user2_conversations.pluck(:user1)
  end

  def has_seen_notifications
    self.notifications.unseen.each do |notification|
      notification.seen
    end
  end

  def unseen_notifications_number
    self.notifications.unseen.count
  end
end
