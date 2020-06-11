class ConversationsChannel < ApplicationCable::Channel
  def subscribed
   stream_from "conversations_channel"
  end

  def receive(data)
    # do something similar to message receive
    @user = User.find(JWT.decode(data["user_id"], 'secret', true, algorithm: 'HS256')[0]["user_id"])
    # BROADCAST TO CONVERSATIONS_CHANNEL
    if @user
      @conversation = Conversation.create(title: data["title"], topic: data["topic"])
      # ADD USERS (VIA USERCONVERSATIONS)
      UserConversation.create(user_id: @user.id, conversation_id: @conversation.id)
      @users = data["users"]
      @users.each do |user|
        if (user["id"] != @user.id)
            UserConversation.create(user_id: user["id"], conversation_id: @conversation.id)
        end
      end
      ActionCable.server.broadcast("conversations_channel", @conversation)
    end
  end

  def unsubscribed
    stop_all_streams
  end
end
