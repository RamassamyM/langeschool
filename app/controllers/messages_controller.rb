class MessagesController < ApplicationController

  def index
    @unread_messages =  Message.where(recipient: User.first).where(read: false).order(:created_at)

  end

end
