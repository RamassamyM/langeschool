class ConversationsController < ApplicationController
  before_action :set_conversation, only: %i(show)

  def index
    set_conversations
  end

  def new
    @conversation = Conversation.new
    @conversation.last_update = Time.zone.now
    if current_user.id > params(:user).id
      @conversation.user1 = params(:user)
      @conversation.user2 = current_user
    elsif current_user.id < params(:user).id
      @conversation.user2 = params(:user)
      @conversation.user1 = current_user
    end
    if @conversation.save
      redirect_to conversation_path(@conversation)
    else
      set_conversations
      flash[:alert] = 'Désolé, cette conversation n\'a pu être créée.'
      redirect_to classrooms_path
    end
  end

  def show
    @message = Message.new
    @messages = @conversation.messages.for_display
    @interlocutor = interlocutor(@conversation)
    set_read_for_messages_from_interlocutor(@messages)
  end

  def create
    @conversation = Conversation.new
    @conversation.last_update = Time.zone.now
    if current_user.id > conversation_params[:user].to_i
      @conversation.user1 = User.find(conversation_params[:user])
      @conversation.user2 = current_user
    elsif current_user.id < conversation_params[:user].to_i
      @conversation.user2 = User.find(conversation_params[:user])
      @conversation.user1 = current_user
    end
    if @conversation.save
      redirect_to conversation_path(@conversation)
    else
      previous_conversations = Conversation.where(user1: @conversation.user1, user2: @conversation.user2)
      if  previous_conversations.count > 0
        redirect_to previous_conversations.first
      else
        set_conversations
        flash[:alert] = 'Désolé, cette conversation n\'a pu être créée.'
        render 'classroom#index'
      end
    end
  end

  private

  def set_read_for_messages_from_interlocutor(messages)
    messages.each do |message|
      if message.author != current_user
        message.read
      end
    end
  end

  def interlocutor(conversation)
    if conversation.user1 == current_user
      conversation.user2
    else
      conversation.user1
    end
  end

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
