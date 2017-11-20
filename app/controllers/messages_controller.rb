class MessagesController < ApplicationController
  validates :content, presence: true
end
