class ConversationsChannel < ApplicationCable::Channel
  def subscribed
   stream_from "conversations_channel"
  end

  def unsubscribed
    stop_all_streams
  end
end
