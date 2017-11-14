class Conversation < ApplicationRecord
  has_many :conversations
  has_many :users, through: :participantlinks
end
