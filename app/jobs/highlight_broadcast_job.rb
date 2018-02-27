class HighlightBroadcastJob < ApplicationJob
  queue_as :default

  def perform(messagable)
    if messagable.class.name == "Channel"
      messagable.notify_users.each do |user_id|
        ActionCable.server.broadcast("user_#{user_id}", {
          type: messagable.class.name,
          id: messagable.id
        })          
      end
    elsif messagable.class.name == "Talk"
      user_id = messagable.user_one_id == messagable.notify_user_id ? messagable.user_two_id : messagable.user_one_id 
      ActionCable.server.broadcast("user_#{messagable.notify_user_id}", {
        type: messagable.class.name,
        id: user_id
      })
    end
  end
end