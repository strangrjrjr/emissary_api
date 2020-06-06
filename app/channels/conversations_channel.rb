class ConversationsChannel < ApplicationCable::Channel
  def subscribed
   stream_from "conversations_channel"
    # @conversation = Conversation.find_by(conversation_params)
  end

  def unsubscribed
    stop_all_streams
  end
end
