class MessagesChannel < ApplicationCable::Channel
  def subscribed
    conversation = Conversation.find(params[:id])
    stream_from "conversation_channel_#{conversation.id}"
  end

  def receive(data)
    leeway = 30
    @user = User.find(JWT.decode(data["user_id"], 'secret', true, {exp_leeway: leeway, algorithm: 'HS256'})[0]["user_id"])
    @conversation = Conversation.find(data["conversation_id"])
    if @user
      if @conversation.users.include?(@user)
        @message = Message.create(text: data["text"], user_id: @user.id, conversation_id: @conversation.id)
        ActionCable.server.broadcast("conversation_channel_#{@conversation.id}", @message)
      end
    end
  end

  def unsubscribed
    stop_all_streams
  end
end
