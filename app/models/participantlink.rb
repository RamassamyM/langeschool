class Participantlink < ApplicationRecord
  belongs_to :conversation
  belongs_to :user
  validates :user, :conversation, presence: true
end
