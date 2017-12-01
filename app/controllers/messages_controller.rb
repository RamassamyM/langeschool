class MessagesController < ApplicationController
  after_action :last_update_conversation, only: [:create]

  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.new(message_params)
    @message.author = current_user
    if @message.save
      create_notification(@message)
      respond_to do |format|
        format.html { redirect_to conversation_path(@conversation) }
        format.js
      end
    else
      respond_to do |format|
        format.html { render 'conversations/show' }
        format.js
      end
    end
  end

  def show
    redirect_to conversation_path(Message.find(params[:id]).conversation)
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def last_update_conversation
    conversation = Conversation.find(params[:conversation_id])
    conversation.update(last_update: @message.created_at)
  end

  def create_notification(message)
    notification = Notification.new(notificable: message, is_seen: false,
                                    user: message.recipient,
                                    picture_url: build_picture_path(message.author),
                                    notification_message: "#{message.author.fullname} vous a écrit.")
    if notification.save!
      puts "La notif de nouveau message de la part de #{message.author.fullname} à \
      #{notification.user.fullname} a bien été créée"
    else
      puts "ERREUR dans la sauvegarde de notif de nouveau message \
      de #{message.author.fullname} \
      à #{message.recipient.fullname}"
    end
  end

  def build_picture_path(user)
    if user.avatar.path
      "http://res.cloudinary.com/langeconnect/image/upload/#{user.avatar.path}"
    else
      "http://res.cloudinary.com/langeconnect/image/upload/v1511990835/family_fb6mx3.png"
    end
  end
end
