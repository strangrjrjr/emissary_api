class AppearancesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "appearances_channel"
  end

  def unsubscribed
    stop_all_streams
  end
end
