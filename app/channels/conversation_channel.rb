class ConversationChannel < ApplicationCable::Channel
  def subscribed
    conversation = Conversation.find(params[:conversation_id])
    if current_user == conversation.user1 || current_user == conversation.user2
      stream_from "conversation_channel_#{ params[:conversation_id] }"
    else
      self.unsubscribed
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

end
