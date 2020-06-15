class ConversationsChannel < ApplicationCable::Channel
  def subscribed
   stream_from "conversations_channel"
  end

  def receive(data)
    # do something similar to message receive
    leeway = 30
    @user = User.find(JWT.decode(data["user_id"], ENV['JWT_SECRET'], true, {exp_leeway: leeway, algorithm: 'HS256'})[0]["user_id"])
    @conversation = Conversation.create(title: data["title"], topic: data["topic"])
    # ADD USERS (VIA USERCONVERSATIONS)
    UserConversation.create(user_id: @user.id, conversation_id: @conversation.id)
    @users = data["users"]
    @users.each {|user| UserConversation.create(user_id: user["id"], conversation_id: @conversation.id)}
    # BROADCAST TO CONVERSATIONS_CHANNEL
    if @user
        ActionCable.server.broadcast("conversations_channel", @conversation)
    end
  end

  def unsubscribed
    stop_all_streams
  end
end
