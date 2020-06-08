class ConversationsChannel < ApplicationCable::Channel
  def subscribed
   stream_from "conversations_channel"
  end

  def receive(data)
    # do something similar to message receive
    byebug
    @user = User.find(JWT.decode(data["user_id"], 'secret', true, algorithm: 'HS256')[0]["user_id"])
    @conversation = Conversation.create(data["title"], data["topic"])
    # CREATE CONVERSATION
    # ADD USERS (VIA USERCONVERSATIONS)
    # BROADCAST TO CONVERSATIONS_CHANNEL
    if @user
    #   if @conversation.users.include?(@user)
    #     @message = Message.create(text: data["text"], user_id: @user.id, conversation_id: @conversation.id)
        ActionCable.server.broadcast("conversations_channel", @conversation)
    #   end
    end
  end

  def unsubscribed
    stop_all_streams
  end
end
