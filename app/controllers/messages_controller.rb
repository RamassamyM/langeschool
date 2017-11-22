class MessagesController < ApplicationController
  after_action :last_update_conversation, only: [:create]

  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.new(message_params)
    @message.author = current_user
    if @message.save
      respond_to do |format|
        format.html { redirect_to conversation_path(@conversation) }
        format.js  # <-- will render `app/views/rviews/create.ejs.erb`
      end
    else
      respond_to do |format|
        format.html { render 'conversations/show' }
        format.js # <-- idem
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def last_update_conversation
    Conversation.find(params[:conversation_id]).last_update = @message.created_at
  end

end



