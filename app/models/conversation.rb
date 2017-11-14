class Conversation < ApplicationRecord
  has_many :conversations
  has_many :participantlinks
  has_many :users, through: :participantlinks
  has_many :messages

end
