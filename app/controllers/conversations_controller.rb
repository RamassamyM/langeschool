class ConversationsController < ApplicationController
  before_action :set_conversation, only: %i(show)

  def index
    set_conversations
  end

  def show
    @message = Message.new
    @messages = @conversation.messages.order(:created_at)
    if @conversation.user1 == current_user
      @interlocutor = @conversation.user2
    else
      @interlocutor = @conversation.user1
    end
  end

  def create
    @conversation = Conversation.new
    @conversation.last_update = Time.zone.now
    if current_user.id > conversation_params(:user).id
      @conversation.user1 = conversation_params(:user)
      @conversation.user2 = current_user
    elsif current_user.id < conversation_params(:user).id
      @conversation.user2 = conversation_params(:user)
      @conversation.user1 = current_user
    end
    if @conversation.save
      redirect_to conversation_path(@conversation)
    else
      set_conversations
      flash[:alert] = 'Désolé, cette conversation n\'a pu être créée.'
      redirect_to conversations_path
    end
  end

  private

  def conversation_params
    params.require(:conversation).permit(:user)
  end

  def set_conversations
    @conversations = current_user.conversations
  end

  def set_conversation
    @conversation = Conversation.find(params[:id])
  end
end
