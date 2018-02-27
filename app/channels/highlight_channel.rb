class HighlightChannel < ApplicationCable::Channel
  def subscribed
    stream_from "user_#{current_user.id}"
  end

  def receive
  end
end
