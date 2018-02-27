class Message < ApplicationRecord
  belongs_to :messagable, polymorphic: true
  belongs_to :user
  validates_presence_of :body, :user

  after_create_commit {MessageBroadcastJob.perform_later self}
  after_create_commit :notify_users
  
  private

    def notify_users
      if self.messagable_type == "Channel"
        self.messagable.notify_users = self.messagable.team.my_users.pluck(:id)
        self.messagable.notify_users.delete self.user.id
      elsif self.messagable_type == "Talk"
        user_id = self.messagable.user_one_id == self.user.id ? self.messagable.user_two_id : self.messagable.user_one_id 
        self.messagable.notify_user_id = user_id
      end        
      
      HighlightBroadcastJob.perform_later self.messagable if self.messagable.save
    end
end